import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistListItemModel extends BaseModel {
  bool _checked = false;
  bool get checked => _checked;
  set checked(bool value) {
    _checked = value;
    notifyListeners();
  }

  bool _showCheckbox = false;
  bool get showCheckbox => _showCheckbox;
  set showCheckbox(bool value) {
    _showCheckbox = value;
    if (value) checked = false;
    notifyListeners();
  }
}
