import 'package:flutter/material.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:provider/provider.dart';

class ChecklistFilter extends StatefulWidget {
  @override
  _ChecklistFilterState createState() => _ChecklistFilterState();
}

class _ChecklistFilterState extends State<ChecklistFilter> {
  Map<String, bool> filterStates = {
    'Luggage': false,
    'Clothing': false,
    'Electronics': false,
    'Food': false,
    'Documents': false,
    'Misc': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: Styles.screenContentPadding,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCheckbox('Luggage'),
                  _buildCheckbox('Electronics'),
                  _buildCheckbox('Documents'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCheckbox('Clothing'),
                  _buildCheckbox('Food'),
                  _buildCheckbox('Misc'),
                ],
              ),
            ],
          ),
          FlatButton(
              child: Text(
                'Apply filters',
                style: Styles.textFormField,
              ),
              onPressed: () {
                setState(() =>
                    {Provider.of<ChecklistModel>(context).refreshFilters()});
              })
        ]));
  }

  Widget _buildCheckbox(String title) {
    return Row(
      children: <Widget>[
        Checkbox(
            checkColor: Theme.of(context).primaryColor,
            value: Provider.of<ChecklistModel>(context).filterStates[title],
            onChanged: (value) {
              if (value) {
                Provider.of<ChecklistModel>(context).enableFilter(title);
              } else {
                Provider.of<ChecklistModel>(context).disableFilter(title);
              }
              setState(() => Provider.of<ChecklistModel>(context)
                  .filterStates[title] = value);
            }),
        Text(title, style: Styles.textFilter),
      ],
    );
  }
}
