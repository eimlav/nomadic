import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_delete_view_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class ChecklistDeleteView extends StatefulWidget {
  final ChecklistItem checklistItem;

  ChecklistDeleteView(this.checklistItem);

  @override
  _ChecklistDeleteViewState createState() => _ChecklistDeleteViewState();
}

class _ChecklistDeleteViewState extends State<ChecklistDeleteView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistDeleteViewModel>(
        model: ChecklistDeleteViewModel(dbService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('checklist'),
              ),
              body: SafeArea(
                child: _buildContent(context, model, child),
              ),
            ));
  }

  Widget _buildContent(
      BuildContext context, ChecklistDeleteViewModel model, Widget child) {
    return Container(
        padding: Styles.screenContentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Are you sure you wish to delete "${widget.checklistItem.name}"?',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Styles.textButtonContrast,
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SubmitButton('Cancel', () {
                  Navigator.of(context).pop();
                  return true;
                }, theme: true),
                UIHelper.horizontalSpaceMedium,
                SubmitButton('Delete', () async {
                  return model.deleteChecklistItem(widget.checklistItem.id);
                }, postCallback: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(RoutePaths.Checklist);
                  return;
                }, theme: true),
              ],
            )
          ],
        ));
  }
}
