import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_add_bottomsheet_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

class ChecklistAddBottomSheet extends StatefulWidget {
  ChecklistAddBottomSheet();

  @override
  _ChecklistAddBottomSheetState createState() =>
      _ChecklistAddBottomSheetState();
}

class _ChecklistAddBottomSheetState extends State<ChecklistAddBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistAddBottomSheetModel>(
        model: ChecklistAddBottomSheetModel(dbService: Provider.of(context)),
        builder: (context, model, child) => model.busy
            ? Center(
                child: SpinKitWave(color: Colors.red, size: 35.0),
              )
            : _buildFormUI(context, model, child));
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
        child: Container(
          padding: Styles.screenContentPadding,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                style: Styles.textDefaultContrast,
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
                style: Styles.textDefaultContrast,
                decoration: InputDecoration(
                    labelText: 'quantity',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
                initialValue: '1',
                maxLines: 1,
                maxLength: FormConstants.maxQuantity,
                keyboardType: TextInputType.number,
                onSaved: (value) => model.form["quantity"] = value,
                validator: (value) => model.validateQuantityField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                style: Styles.textDefaultContrast,
                decoration: InputDecoration(
                    labelText: 'category',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
                maxLines: 1,
                maxLength: FormConstants.categoryMaxLength,
                keyboardType: TextInputType.text,
                onSaved: (value) => model.form["category"] = value,
                validator: (value) => model.validateCategoryField(value),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                style: Styles.textDefaultContrast,
                decoration: InputDecoration(
                    labelText: 'description',
                    labelStyle: Styles.textFormFieldContrast,
                    errorStyle: Styles.textFormFieldContrast,
                    counterStyle: Styles.textFormFieldContrast),
                cursorColor: Colors.white,
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
                      color: Colors.grey[200],
                      textTheme: ButtonTextTheme.accent,
                      splashColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.5))),
                      onPressed: () async {
                        var result = await model.validateForm();
                        if (result >= 0 && this.mounted) {
                          // TODO: Fix this fucking horrible hack that keeps me up at night.
                          Navigator.of(this.context).pop(this.context);
                          Navigator.of(this.context).pop(this.context);
                          Navigator.of(this.context)
                              .pushNamed(RoutePaths.Checklist);
                          return;
                        } else {
                          print('error occured adding ChecklistItem');
                        }
                      },
                      child: Text('Add', style: Styles.textButtonContrast));
                },
              ),
            ],
          ),
        ));
  }
}
