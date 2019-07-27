import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_photo_view_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class ChecklistPhotoView extends StatefulWidget {
  final ChecklistItem checklistItem;

  ChecklistPhotoView(this.checklistItem);

  @override
  _ChecklistPhotoViewState createState() => _ChecklistPhotoViewState();
}

class _ChecklistPhotoViewState extends State<ChecklistPhotoView> {
  int _currentPhotoIndex = 0;
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistPhotoViewModel>(
        model: ChecklistPhotoViewModel(dbService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('checklist'),
              ),
              body: SafeArea(
                child: _buildContent(context, model, child),
              ),
            ));
  }

  Widget _buildContent(
      BuildContext context, ChecklistPhotoViewModel model, Widget child) {
    return Container(
        padding: Styles.screenContentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            UIHelper.verticalSpaceMedium,
            _buildPageNumber(),
            UIHelper.verticalSpaceSmall,
            _buildGallery(),
            UIHelper.verticalSpaceSmall,
            _buildActionButtons(model),
          ],
        ));
  }

  Widget _buildPageNumber() {
    int currentIndex = 0, gallerySize = 0;
    if (widget.checklistItem.photos != null &&
        widget.checklistItem.photos.isNotEmpty) {
      currentIndex = _currentPhotoIndex + 1;
      gallerySize = widget.checklistItem.photos.split(',').length;
    }

    return Container(
      child: Text(
        "$currentIndex of $gallerySize",
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _buildGallery() {
    List<PhotoViewGalleryPageOptions> pageOptions =
        List<PhotoViewGalleryPageOptions>();
    if (widget.checklistItem.photos != null &&
        widget.checklistItem.photos.isNotEmpty) {
      widget.checklistItem.photos.split(',').forEach((photo) {
        pageOptions.add(_getPhotoViewGalleryPageOptions(photo));
      });
    }

    if (widget.checklistItem.photos == null ||
        widget.checklistItem.photos.isEmpty)
      pageOptions.add(_getPhotoViewGalleryPageOptionsEmpty());

    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: PhotoViewGallery(
          onPageChanged: (index) {
            setState(() => _currentPhotoIndex = index);
          },
          pageOptions: pageOptions,
          backgroundDecoration: BoxDecoration(color: Colors.grey[200]),
        ));
  }

  PhotoViewGalleryPageOptions _getPhotoViewGalleryPageOptions(String imageURL) {
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(imageURL),
    );
  }

  PhotoViewGalleryPageOptions _getPhotoViewGalleryPageOptionsEmpty() {
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage('assets/images/no_photos.png'),
    );
  }

  Widget _buildActionButtons(ChecklistPhotoViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildActionButtonCapture(model),
        _buildActionButtonAdd(model),
        _buildActionButtonDelete(model),
      ],
    );
  }

  Widget _buildActionButtonCapture(ChecklistPhotoViewModel model) {
    return FlatButton(
      onPressed: () => _displayImagePicker(model, ImageSource.camera),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_a_photo, color: Colors.grey[400]),
          Container(width: 10.0),
          Text('Capture a photo'),
        ],
      ),
    );
  }

  Widget _buildActionButtonAdd(ChecklistPhotoViewModel model) {
    return FlatButton(
      onPressed: () => _displayImagePicker(model, ImageSource.gallery),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.photo, color: Colors.grey[400]),
          Container(width: 10.0),
          Text('Add a photo'),
        ],
      ),
    );
  }

  Widget _buildActionButtonDelete(ChecklistPhotoViewModel model) {
    return widget.checklistItem.photos != null &&
            widget.checklistItem.photos.isNotEmpty
        ? FlatButton(
            onPressed: () => _displayDeleteDialog(model),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.delete, color: Colors.grey[400]),
                Container(width: 10.0),
                Text('Delete photo'),
              ],
            ),
          )
        : Container();
  }

  void _displayImagePicker(
      ChecklistPhotoViewModel model, ImageSource imageSource) async {
    _imageFile = await ImagePicker.pickImage(source: imageSource);
    if (_imageFile != null) {
      model.savePhoto(_imageFile, widget.checklistItem);
    }
  }

  void _displayDeleteDialog(ChecklistPhotoViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Photo"),
          content: Text(
              "Are you sure you want to delete this photo? Once done it cannot be reverted."),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel", style: Styles.textButtonContrast),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Delete", style: Styles.textButtonContrast),
              onPressed: () async {
                await model.deletePhoto(
                    _currentPhotoIndex, widget.checklistItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
