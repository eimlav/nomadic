import 'package:flutter/widgets.dart';
import 'package:nomadic/core/constants/form_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/utils/validator.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistEditViewModel extends BaseModel {
  DBService _dbService;
  bool autoValidate = false;
  Map<String, dynamic> form = Map<String, dynamic>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChecklistEditViewModel({
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
    return Validator.stringLengthValidator(value, 'category',
        FormConstants.categoryMinLength, FormConstants.categoryMaxLength);
  }

  // Validate description field
  String validateDescriptionField(String value) {
    return Validator.stringLengthValidator(value, 'description',
        FormConstants.descriptionMinLength, FormConstants.descriptionMaxLength);
  }

  // Validate form.
  Future<int> validateForm() async {
    setBusy(true);

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // Build ChecklistItem
      var checklistItem = ChecklistItem(
        id: form['id'],
        name: form['name'],
        description: form['description'] == null ? '' : form['description'],
        quantity: int.parse(form['quantity']),
        category: form['category'] == null ? '' : form['category'],
        photos: '',
      );

      await _dbService.updateChecklistItem(checklistItem);
      setBusy(false);
    } else {
      autoValidate = true;
      notifyListeners();
      setBusy(false);
    }
  }
}
