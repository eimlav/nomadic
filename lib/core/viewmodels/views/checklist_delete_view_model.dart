import 'package:flutter/widgets.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';

class ChecklistDeleteViewModel extends BaseModel {
  DBService _dbService;

  ChecklistDeleteViewModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  Future<bool> deleteChecklistItem(int id) async {
    setBusy(true);
    await _dbService.deleteChecklistItem(id);
    setBusy(false);
    return false;
  }
}
