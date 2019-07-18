import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistModel extends BaseModel {
  Future<bool> createChecklistItem(ChecklistItem checklistItem) async {
    setBusy(true);

    setBusy(false);
  }
}
