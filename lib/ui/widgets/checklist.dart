import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/checklist_filter.dart';
import 'package:nomadic/ui/widgets/checklist_listitem.dart';
import 'package:provider/provider.dart';

class Checklist extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  bool _showFilterDialog = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistModel>(
        model: ChecklistModel(dbService: Provider.of(context)),
        onModelReady: (model) => model.getChecklistItems(),
        builder: (context, model, child) => model.busy
            ? Center(
                child: SpinKitWave(color: Colors.red, size: 35.0),
              )
            : model.checklistItems.length == 0
                ? Column(
                    children: <Widget>[
                      _buildHeader(context, model, child),
                      Text(
                        'No items found. Add some below!',
                        style: Styles.textButtonContrast,
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: model.checklistItems.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildHeader(context, model, child);
                      }
                      index -= 1;

                      return ChecklistListItem(
                          model.checklistItems[index], model);
                    }));
  }

  Widget _buildHeader(
      BuildContext context, ChecklistModel model, Widget child) {
    var status = model.showCheckboxes ? 'Hide' : 'Show';
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
              child: Text(
                '$status checklist',
                style: Styles.textFormField,
              ),
              onPressed: () {
                model.showCheckboxes = !model.showCheckboxes;
                model.checklistMode(model.showCheckboxes);
              }),
          model.showCheckboxes
              ? Text(
                  '${model.checklistItemsCheckedCount()}/${model.checklistItems.length}',
                  style: Styles.textFormField,
                )
              : Container(),
          FlatButton(
              child: Text(
                'Filter (${model.filtersEnabledCount()})',
                style: Styles.textFormField,
              ),
              onPressed: () {
                if (this._showFilterDialog == true) {
                  // model.getChecklistItems();
                  // model.filters = [];
                }
                setState(
                    () => this._showFilterDialog = !this._showFilterDialog);
              })
        ],
      ),
      _showFilterDialog
          ? ChecklistFilter()
          : Container(), // ChecklistFilter will reinstantiate when busy is set :(
      Divider(),
    ]);
  }
}
