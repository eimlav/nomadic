import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/checklist_listitem.dart';
import 'package:provider/provider.dart';

class Checklist extends StatelessWidget {
  const Checklist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistModel>(
        model: ChecklistModel(dbService: Provider.of(context)),
        onModelReady: (model) => model.getChecklistItems(),
        builder: (context, model, child) => model.busy
            ? Center(
                child: SpinKitWave(color: Colors.red, size: 35.0),
              )
            : ListView.builder(
                itemCount: model.checklistItems.length + 1,
                itemBuilder: (context, index) {
                  print(index);
                  if (index == 0) {
                    var status = model.showCheckboxes ? 'Hide' : 'Show';
                    return FlatButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$status checklist',
                                style: Styles.textFormField,
                              ),
                              model.showCheckboxes
                                  ? Text(
                                      '${model.checklistCount}/${model.checklistItems.length}',
                                      style: Styles.textButtonContrast,
                                    )
                                  : Container()
                            ]),
                        onPressed: () {
                          model.showCheckboxes = !model.showCheckboxes;
                          model.checklistMode(model.showCheckboxes);
                        });
                  }
                  index -= 1;

                  return ChecklistListItem(model.checklistItems[index], model);
                }));
  }
}
