import 'package:flutter/material.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_view_model.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_listitem_model.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_model.dart';
import 'package:nomadic/ui/shared/defaults.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/checklist_view_bottomsheet.dart';
import 'package:provider/provider.dart';

class ChecklistListItem extends StatefulWidget {
  final ChecklistItem checklistItem;
  final ChecklistModel checklistModel;

  const ChecklistListItem(this.checklistItem, this.checklistModel);

  @override
  _ChecklistListItemState createState() => _ChecklistListItemState();
}

class _ChecklistListItemState extends State<ChecklistListItem> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistListItemModel>(
        model: ChecklistListItemModel(),
        builder: (context, model, child) => GestureDetector(
              onTap: () async {
                var checklistViewModel =
                    Provider.of<ChecklistViewModel>(context);

                checklistViewModel.showFloatingActionButton = false;
                checklistViewModel.showDeleteIcon = true;
                checklistViewModel.currentChecklistItem = widget.checklistItem;

                var sheetController = showBottomSheet(
                    context: context,
                    builder: (context) =>
                        ChecklistViewBottomSheet(widget.checklistItem));
                sheetController.closed.then((value) {
                  checklistViewModel.showFloatingActionButton = true;
                  checklistViewModel.showDeleteIcon = false;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    widget.checklistModel.showCheckboxes
                        ? Checkbox(
                            checkColor: Theme.of(context).primaryColor,
                            value: _checked,
                            onChanged: (value) {
                              setState(() => _checked = value);
                              if (value) {
                                Provider.of<ChecklistModel>(context)
                                    .incrementChecklistCount();
                              } else {
                                Provider.of<ChecklistModel>(context)
                                    .decrementChecklistCount();
                              }
                            })
                        : Container(),
                    _buildFirstSection(),
                    UIHelper.horizontalSpaceSmall,
                    Expanded(child: _buildSecondSection()),
                  ],
                ),
              ),
            ));
  }

  Widget _buildFirstSection() {
    return CircleAvatar(
      backgroundColor: Colors.grey[400],
      foregroundColor: Colors.white,
      backgroundImage: widget.checklistItem.hasPhotos()
          ? AssetImage(widget.checklistItem.getPhotos()[0])
          : AssetImage(Defaults.placeholderImage),
      radius: 20.0,
    );
  }

  Widget _buildSecondSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(widget.checklistItem.name,
              style: Styles.textDefault, overflow: TextOverflow.ellipsis),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildSecondSectionCameraIcon(),
              UIHelper.horizontalSpaceVerySmall,
              Text(
                "${widget.checklistItem.category} | x${widget.checklistItem.quantity}",
                style: Styles.textSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSecondSectionCameraIcon() {
    if (widget.checklistItem.hasPhotos())
      return Icon(Icons.camera_alt, color: Colors.grey[400], size: 14.0);
    return Container();
  }
}
