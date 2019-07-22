import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_add_bottomsheet_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class ChecklistAddBottomSheet extends StatefulWidget {
  ChecklistAddBottomSheet();

  @override
  _ChecklistAddBottomSheetState createState() =>
      _ChecklistAddBottomSheetState();
}

class _ChecklistAddBottomSheetState extends State<ChecklistAddBottomSheet> {
  String _dropDownValue = 'Misc';

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistAddBottomSheetModel>(
        model: ChecklistAddBottomSheetModel(dbService: Provider.of(context)),
        builder: (context, model, child) =>
            _buildFormUI(context, model, child));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildFormUI(
      BuildContext context, ChecklistAddBottomSheetModel model, Widget child) {
    return Form(
        key: model.formKey,
        autovalidate: model.autoValidate,
        child: SingleChildScrollView(
            child: Container(
          padding: Styles.screenContentPadding,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                style: Styles.textFormFieldInputContrast,
                decoration: InputDecoration(
                    labelText: 'name',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
                maxLines: 1,
                maxLength: FormConstants.nameMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["name"] = value,
                validator: (value) => model.validateNameField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                style: Styles.textFormFieldInputContrast,
                decoration: InputDecoration(
                    labelText: 'quantity',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
                initialValue: '1',
                maxLines: 1,
                maxLength: FormConstants.maxQuantity.toString().length,
                keyboardType: TextInputType.number,
                onSaved: (value) => model.form["quantity"] = value,
                validator: (value) => model.validateQuantityField(value),
              ),
              UIHelper.verticalSpaceMedium,
              Text('category', style: Styles.textFieldHeaderContrast),
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
                  model.form["category"] = _dropDownValue;
                },
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                style: Styles.textFormFieldInputContrast,
                decoration: InputDecoration(
                    labelText: 'description',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
                maxLines: 5,
                maxLength: FormConstants.descriptionMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["description"] = value,
                validator: (value) => model.validateDescriptionField(value),
              ),
              UIHelper.verticalSpaceMedium,
              SubmitButton(
                'Add',
                () async {
                  return await model.validateForm();
                },
                postCallback: () {
                  // TODO: Fix this fucking horrible hack that keeps me up at night.
                  Navigator.of(this.context).pop(this.context);
                  Navigator.of(this.context).pop(this.context);
                  Navigator.of(this.context).pushNamed(RoutePaths.Checklist);
                  return;
                },
                theme: true,
              )
            ],
          ),
        )));
  }
}
