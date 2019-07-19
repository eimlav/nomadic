import 'package:flutter/widgets.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistModel extends BaseModel {
  DBService _dbService;

  ChecklistModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  List<ChecklistItem> checklistItems;

  Future getChecklistItems() async {
    setBusy(true);
    checklistItems = await _dbService.getChecklistItems();
    setBusy(false);
    notifyListeners();
  }
}
