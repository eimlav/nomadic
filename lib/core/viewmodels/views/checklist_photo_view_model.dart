import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/services/db_service.dart';
import 'package:nomadic/core/viewmodels/base_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChecklistPhotoViewModel extends BaseModel {
  DBService _dbService;

  ChecklistPhotoViewModel({
    @required DBService dbService,
  }) : _dbService = dbService;

  Future<void> savePhoto(File photo, ChecklistItem checklistItem) async {
    // Save photo to device
    String path;
    await getApplicationDocumentsDirectory().then((value) {
      path = value.path;
    });
    String photoName = basename(photo.path);
    await photo.copy('$path/$photoName');

    // Save photo path to db
    List<String> updatedPhotos =
        checklistItem.photos.isEmpty ? [] : checklistItem.photos.split(',');
    updatedPhotos.add('$path/$photoName');
    checklistItem.photos = updatedPhotos.join(',');

    await _dbService.updateChecklistItem(checklistItem);
    notifyListeners();
  }

  Future<void> deletePhoto(int photoIndex, ChecklistItem checklistItem) async {
    setBusy(true);

    // Remove photo from device
    List<String> updatedPhotos =
        checklistItem.photos.isEmpty ? [] : checklistItem.photos.split(',');
    String path = updatedPhotos[photoIndex];
    File photo = File(path);
    await photo.delete();

    // Remove photo path from db
    updatedPhotos.removeAt(photoIndex);
    checklistItem.photos = updatedPhotos.join(',');
    await _dbService.updateChecklistItem(checklistItem);

    setBusy(false);
    notifyListeners();
  }
}
