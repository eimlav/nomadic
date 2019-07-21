import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class CurrenciesModel extends BaseModel {
  DBService _dbService;

  final baseCurrency = 'GBP';
  final currenciesSheetURL =
      'https://docs.google.com/spreadsheets/d/15UORttssd5mlAEWQ0Y9D6ELht0N4yZk4u9Ny1ZmFmYs/export?format=csv&gid=0';

  Map<String, double> exchangeRates = {};
  DateTime lastUpdate;

  CurrenciesModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  Future<void> fetchCurrencies() async {
    setBusy(true);
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
        }
        lastUpdate = DateTime.now();
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
