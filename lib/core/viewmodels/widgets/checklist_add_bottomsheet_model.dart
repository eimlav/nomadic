import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/utils/validator.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistAddBottomSheetModel extends BaseModel {
  DBService _dbService;
  bool autoValidate = false;
  Map<String, dynamic> form = {'category': 'Misc'};
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChecklistAddBottomSheetModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  // Validate name field
  String validateNameField(String value) {
    return Validator.stringLengthValidator(value, 'name',
        FormConstants.nameMinLength, FormConstants.nameMaxLength);
  }

  // Validate name field
  String validateQuantityField(String value) {
    return Validator.stringNumberSizeValidator(value, 'quantity',
        FormConstants.minQuantity, FormConstants.maxQuantity);
  }

  // Validate category field
  String validateCategoryField(String value) {
    var result = checklistItemCategoriesName[value];
    if (result == null) {
      return 'category should be one of those specifed';
    }
    return null;
  }

  // Validate description field
  String validateDescriptionField(String value) {
    return Validator.stringLengthValidator(value, 'description',
        FormConstants.descriptionMinLength, FormConstants.descriptionMaxLength);
  }

  // Validate form.
  Future<bool> validateForm() async {
    setBusy(true);

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // Build ChecklistItem
      var checklistItem = ChecklistItem(
        name: form['name'],
        description: form['description'] == null ? '' : form['description'],
        quantity: int.parse(form['quantity']),
        category: form['category'] == null ? '' : form['category'],
        photos: '',
      );

      await _dbService.insertChecklistItem(checklistItem);
      setBusy(false);
      return false;
    } else {
      autoValidate = true;
      notifyListeners();
      setBusy(false);
      return true;
    }
  }
}
