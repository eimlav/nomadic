import 'package:flutter/widgets.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistModel extends BaseModel {
  DBService _dbService;

  ChecklistModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  int _checklistCount = 0;
  int get checklistCount => _checklistCount;
  set checklistCount(value) {
    _checklistCount = value;
    notifyListeners();
  }

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
    setBusy(false);
    notifyListeners();
  }

  void checklistMode(bool value) {
    checklistCount = 0;
    showCheckboxes = value;
    notifyListeners();
  }

  void incrementChecklistCount() {
    checklistCount++;
  }

  void decrementChecklistCount() {
    checklistCount--;
  }
}
