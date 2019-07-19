import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_edit_view_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

class ChecklistEditView extends StatefulWidget {
  final ChecklistItem checklistItem;

  ChecklistEditView(this.checklistItem);

  @override
  _ChecklistEditViewState createState() => _ChecklistEditViewState();
}

class _ChecklistEditViewState extends State<ChecklistEditView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistEditViewModel>(
        model: ChecklistEditViewModel(dbService: Provider.of(context)),
        builder: (context, model, child) => model.busy
            ? Center(
                child: SpinKitWave(color: Colors.red, size: 35.0),
              )
            : Scaffold(
                backgroundColor: Theme.of(context).accentColor,
                appBar: AppBar(
                  title: Text('checklist'),
                ),
                body: SafeArea(
                  child: _buildFormUI(context, model, child),
                ),
              ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildFormUI(
      BuildContext context, ChecklistEditViewModel model, Widget child) {
    return Form(
        key: model.formKey,
        autovalidate: model.autoValidate,
        child: Container(
          padding: Styles.screenContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                initialValue: widget.checklistItem.name,
                style: Styles.textFormFieldInput,
                decoration: InputDecoration(
                    labelText: 'name',
                    labelStyle: Styles.textFormField,
                    errorStyle: Styles.textFormField,
                    counterStyle: Styles.textFormField),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                maxLength: FormConstants.nameMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["name"] = value,
                validator: (value) => model.validateNameField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                initialValue: widget.checklistItem.quantity.toString(),
                style: Styles.textFormFieldInput,
                decoration: InputDecoration(
                    labelText: 'quantity',
                    labelStyle: Styles.textFormField,
                    errorStyle: Styles.textFormField,
                    counterStyle: Styles.textFormField),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                maxLength: FormConstants.maxQuantity.toString().length,
                keyboardType: TextInputType.number,
                onSaved: (value) => model.form["quantity"] = value,
                validator: (value) => model.validateQuantityField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                initialValue: widget.checklistItem.category,
                style: Styles.textFormFieldInput,
                decoration: InputDecoration(
                    labelText: 'category',
                    labelStyle: Styles.textFormField,
                    errorStyle: Styles.textFormField,
                    counterStyle: Styles.textFormField),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                maxLength: FormConstants.categoryMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["category"] = value,
                validator: (value) => model.validateCategoryField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                initialValue: widget.checklistItem.description,
                style: Styles.textFormFieldInput,
                decoration: InputDecoration(
                    labelText: 'description',
                    labelStyle: Styles.textFormField,
                    errorStyle: Styles.textFormField,
                    counterStyle: Styles.textFormField),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                maxLength: FormConstants.descriptionMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["description"] = value,
                validator: (value) => model.validateDescriptionField(value),
              ),
              UIHelper.verticalSpaceMedium,
              Builder(
                builder: (BuildContext context) {
                  return FlatButton(
                      color: Theme.of(context).primaryColor,
                      textTheme: ButtonTextTheme.primary,
                      splashColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.5))),
                      onPressed: () async {
                        model.form['id'] = widget.checklistItem.id;
                        await model.validateForm();
                        // TODO: Fix this monstrosity.
                        Navigator.of(this.context).pop(this.context);
                        Navigator.of(this.context).pop(this.context);
                        Navigator.of(this.context).pop(this.context);
                        Navigator.of(this.context)
                            .pushNamed(RoutePaths.Checklist);
                        return;
                      },
                      child: Text('Save changes', style: Styles.textButton));
                },
              ),
            ],
          ),
        ));
  }
}
