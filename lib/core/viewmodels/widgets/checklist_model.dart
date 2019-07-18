import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistModel extends BaseModel {
  List<ChecklistItem> checklistItems;

  Future getChecklistItems() async {
    setBusy(true);
    checklistItems = await Future.delayed(Duration(seconds: 2), () {
      return [
        ChecklistItem(
            id: 0,
            name: 'Rucksack',
            description: 'A big rucksack',
            category: 'Luggage',
            quantity: 1,
            photos: [])
      ];
    });
    setBusy(false);
  }
}
