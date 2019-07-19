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

  bool _showDeleteIcon = false;

  bool get showDeleteIcon => _showDeleteIcon;

  set showDeleteIcon(bool value) {
    _showDeleteIcon = value;
    notifyListeners();
  }

  ChecklistItem _currentChecklistItem = null;

  ChecklistItem get currentChecklistItem => _currentChecklistItem;

  set currentChecklistItem(ChecklistItem value) {
    _currentChecklistItem = value;
    notifyListeners();
  }

  Checklist checklist = Checklist();
}
