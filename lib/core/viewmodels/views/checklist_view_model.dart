import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistViewModel extends BaseModel {
  bool _showFloatingActionButton = true;
  bool get showFloatingActionButton => _showFloatingActionButton;
  set showFloatingActionButton(bool value) {
    _showFloatingActionButton = value;
    notifyListeners();
  }

  Future<bool> createChecklistItem(ChecklistItem checklistItem) async {
    setBusy(true);

    setBusy(false);
  }
}
