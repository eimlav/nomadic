import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_edit_view_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class ChecklistEditView extends StatefulWidget {
  final ChecklistItem checklistItem;

  ChecklistEditView(this.checklistItem);

  @override
  _ChecklistEditViewState createState() => _ChecklistEditViewState();
}

class _ChecklistEditViewState extends State<ChecklistEditView> {
  String _dropDownValue = 'Misc';

  @override
  Widget initState() {
    super.initState();
    _dropDownValue = widget.checklistItem.category;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistEditViewModel>(
        model: ChecklistEditViewModel(dbService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
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
        child: SingleChildScrollView(
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
              Text('category', style: Styles.textFieldHeader),
              DropdownButton(
                style: Styles.dropDownText,
                value: _dropDownValue,
                items: checklistItemCategoriesName.entries
                    .map<DropdownMenuItem<String>>(
                        (MapEntry<ChecklistItemCategories, String> e) =>
                            DropdownMenuItem<String>(
                              value: e.value,
                              child: Text(e.value),
                            ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _dropDownValue = value);
                  model.form["category"] = value;
                },
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
                maxLines: 5,
                maxLength: FormConstants.descriptionMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["description"] = value,
                validator: (value) => model.validateDescriptionField(value),
              ),
              UIHelper.verticalSpaceMedium,
              SubmitButton('Save changes', () async {
                model.form['id'] = widget.checklistItem.id;
                return await model.validateForm();
              }, postCallback: () {
                // TODO: Fix this monstrosity.
                Navigator.of(this.context).pop(this.context);
                Navigator.of(this.context).pop(this.context);
                Navigator.of(this.context).pop(this.context);
                Navigator.of(this.context).pushNamed(RoutePaths.Checklist);
              }),
            ],
          ),
        )));
  }
}
