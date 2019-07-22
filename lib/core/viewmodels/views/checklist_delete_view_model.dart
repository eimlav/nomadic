import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';
import 'package:path_provider/path_provider.dart';

class ChecklistDeleteViewModel extends BaseModel {
  DBService _dbService;

  ChecklistDeleteViewModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  Future<bool> deleteChecklistItem(ChecklistItem checklistItem) async {
    setBusy(true);

    String applicationPath;
    await getApplicationDocumentsDirectory().then((value) {
      applicationPath = value.path;
    });

    List<String> checklistItemPhotos =
        checklistItem.photos.isEmpty ? [] : checklistItem.photos.split(',');
    for (var photo in checklistItemPhotos) {
      if (photo.contains(applicationPath)) {
        File photoFile = File(photo);
        await photoFile.delete();
      }
    }

    await _dbService.deleteChecklistItem(checklistItem.id);
    setBusy(false);
    return false;
  }
}
