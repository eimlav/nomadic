import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:nomadic/core/enums/connectivity_status.dart';
import 'package:nomadic/core/models/exchange_rate.dart';
import 'package:nomadic/core/services/connectivity_service.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class CurrenciesModel extends BaseModel {
  DBService _dbService;
  ConnectivityService _connectivityService;

  final baseCurrency = 'GBP';
  final currenciesSheetURL =
      'https://docs.google.com/spreadsheets/d/15UORttssd5mlAEWQ0Y9D6ELht0N4yZk4u9Ny1ZmFmYs/export?format=csv&gid=0';

  Map<String, double> exchangeRates = {};
  DateTime updatedAt;

  CurrenciesModel({
    @required DBService dbService,
    @required ConnectivityService connectivityService,
  })  : _dbService = dbService,
        _connectivityService = connectivityService;

  Future<void> fetchCurrencies() async {
    setBusy(true);
    var status = await _connectivityService.getConnectionStatus();
    if (status == ConnectivityStatus.Cellular ||
        status == ConnectivityStatus.WiFi) {
      await fetchCurrenciesFromOnline();
    } else {
      await fetchCurrenciesFromDB();
    }
    setBusy(false);
  }

  Future<void> fetchCurrenciesFromDB() async {
    setBusy(true);

    await _dbService.getExchangeRates().then((dbRates) {
      if (dbRates.isEmpty) {
        setBusy(false);
        notifyListeners();
        return;
      }
      dbRates.forEach((exchangeRate) {
        exchangeRates[exchangeRate.exchangeCurrency] = exchangeRate.rate;
        updatedAt = exchangeRate.updatedAt;
      });
      setBusy(false);
      notifyListeners();
      return;
    });
  }

  Future<void> fetchCurrenciesFromOnline() async {
    // Download CSV file from Google Sheets
    HttpClient client = new HttpClient();
    var _downloadData = StringBuffer();
    await client
        .getUrl(Uri.parse(currenciesSheetURL))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((d) => _downloadData.write(d),
          onDone: () {
        // Parse CSV file contents
        List<List<dynamic>> ratesCSV = const CsvToListConverter()
            .convert(_downloadData.toString().replaceAll('\n', '\r\n'));
        for (var index = 0; index < ratesCSV.length; index++) {
          if (index == 0) continue;
          exchangeRates[ratesCSV[index][0]] = ratesCSV[index][1];
          // Cache to database
          _dbService.insertExchangeRate(ExchangeRate(
            baseCurrency: baseCurrency,
            exchangeCurrency: ratesCSV[index][0],
            rate: ratesCSV[index][1],
            updatedAt: DateTime.now(),
          ));
        }

        updatedAt = DateTime.now();
        setBusy(false);
        notifyListeners();
      });
    }).catchError((error) {
      print('encountered error retrieving exchange rates: ${error.toString()}');
      setBusy(false);
      notifyListeners();
    });
  }
}
