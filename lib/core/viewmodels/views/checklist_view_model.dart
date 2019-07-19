import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';
import 'package:nomadic/ui/widgets/checklist.dart';

class ChecklistViewModel extends BaseModel {
  bool _showFloatingActionButton = true;

  bool get showFloatingActionButton => _showFloatingActionButton;

  set showFloatingActionButton(bool value) {
    _showFloatingActionButton = value;
    notifyListeners();
  }

  Checklist checklist = Checklist();

  Future<bool> createChecklistItem(ChecklistItem checklistItem) async {
    setBusy(true);

    setBusy(false);
  }
}
