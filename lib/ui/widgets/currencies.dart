import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/viewmodels/widgets/currencies_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

class Currencies extends StatefulWidget {
  @override
  _CurrenciesState createState() => _CurrenciesState();
}

// Retrieves exchange rates from a predefined Google Sheet. As such, we can only compare
// one base currency (GBP) against a predefined set of currencies (in the Sheet).
//
// In order to accomodate more flexiblity in the future, a number of changes will need to
// be made.
class _CurrenciesState extends State<Currencies> {
  Map<String, Function> menuChoices = {
    'Add currency': (BuildContext context) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("'Add currency' not implemented."),
      ));
    },
    'Remove currency': (BuildContext context) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("'Remove currency' not implemented."),
      ));
    },
  };

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CurrenciesModel>(
        model: CurrenciesModel(
            dbService: Provider.of(context),
            connectivityService: Provider.of(context)),
        onModelReady: (model) async => await model.fetchCurrencies(),
        builder: (context, model, child) => Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: model.busy
                    ? Center(
                        child: SpinKitWave(color: Colors.red, size: 35.0),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Currencies',
                                style: Styles.textCurrenciesHeader,
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: PopupMenuButton(
                                    itemBuilder: (_) {
                                      List<PopupMenuItem> items = [];
                                      menuChoices.forEach((value, callback) {
                                        items.add(PopupMenuItem(
                                            enabled: false,
                                            child: Text(value,
                                                style: Styles.textDefault),
                                            value: value));
                                      });
                                      return items;
                                    },
                                    child: Icon(Icons.menu,
                                        color: Theme.of(context).primaryColor),
                                  )),
                            ],
                          ),
                          model.exchangeRates.isEmpty
                              ? Text('Unable to fetch exchange rates.',
                                  style: Styles.textDefault)
                              : _buildExchangeRates(context, model),
                          UIHelper.verticalSpaceVerySmall,
                          model.updatedAt != null
                              ? Text(
                                  'last updated ${UIHelper.formatDateTime(model.updatedAt.toLocal())}',
                                  style: Styles.textSmall,
                                  textAlign: TextAlign.right,
                                )
                              : Container(),
                        ],
                      ),
              ),
            ));
  }

  Widget _buildExchangeRates(BuildContext context, CurrenciesModel model) {
    List<Widget> exchangeRateWidgets = [];
    bool showBaseCurrency = true;
    model.exchangeRates.forEach((key, value) {
      exchangeRateWidgets.add(
          _buildExchangeRate(model, key, showBaseCurrency: showBaseCurrency));
      showBaseCurrency = false;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: exchangeRateWidgets,
    );
  }

  Widget _buildExchangeRate(CurrenciesModel model, String currency,
      {bool showBaseCurrency = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          showBaseCurrency
              ? Text(
                  '1 ${model.baseCurrency} equals ',
                  style: Styles.textSmall,
                )
              : Container(),
          Text('${model.exchangeRates[currency]} $currency',
              style: Styles.textDefault),
        ],
      ),
    );
  }
}
