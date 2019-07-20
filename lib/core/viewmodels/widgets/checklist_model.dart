import 'package:flutter/widgets.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistModel extends BaseModel {
  DBService _dbService;
  List<String> filters = [];
  Map<String, bool> filterStates = {
    'Luggage': false,
    'Clothing': false,
    'Electronics': false,
    'Food': false,
    'Documents': false,
    'Misc': false,
  };
  Map<int, bool> checklistItemsChecked = {};

  ChecklistModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  bool _showCheckboxes = false;
  bool get showCheckboxes => _showCheckboxes;
  set showCheckboxes(value) {
    _showCheckboxes = value;
    notifyListeners();
  }

  List<ChecklistItem> checklistItems;

  Future getChecklistItems() async {
    setBusy(true);
    checklistItems = await _dbService.getChecklistItems();
    await Future.delayed(Duration(milliseconds: 150));
    setBusy(false);
    notifyListeners();
  }

  Future getChecklistItemsFiltered(String column, List<String> values) async {
    if (values == null || values.isEmpty)
      checklistItems = await _dbService.getChecklistItems();
    else
      checklistItems =
          await _dbService.getChecklistItemsFiltered(column, values);
    for (var checklistItem in checklistItems) {
      if (checklistItemsChecked[checklistItem.id] == null) {
        checklistItemsChecked[checklistItem.id] = false;
      }
    }
    notifyListeners();
  }

  void checkChecklistItem(int id) {
    checklistItemsChecked[id] = true;
    notifyListeners();
  }

  void uncheckChecklistItem(int id) {
    checklistItemsChecked[id] = false;
    notifyListeners();
  }

  bool isChecklistItemChecked(int id) {
    if (checklistItemsChecked[id] == null) {
      return false;
    }
    return checklistItemsChecked[id];
  }

  int checklistItemsCheckedCount() {
    int count = 0;
    for (var checklistItem in checklistItems) {
      if (checklistItemsChecked.containsKey(checklistItem.id) &&
          checklistItemsChecked[checklistItem.id] == true) count++;
    }
    return count;
  }

  void checklistMode(bool value) {
    showCheckboxes = value;
    notifyListeners();
  }

  void enableFilter(String value) {
    filterStates[value] = true;
    notifyListeners();
  }

  void disableFilter(String value) {
    filterStates[value] = false;
    notifyListeners();
  }

  void refreshFilters() {
    List<String> filters = [];
    filterStates.forEach((key, value) {
      if (value) filters.add(key);
    });
    getChecklistItemsFiltered('category', filters);
    notifyListeners();
  }

  int filtersEnabledCount() {
    int count = 0;
    filterStates.forEach((key, value) {
      if (value) count++;
    });
    return count;
  }
}
