import 'package:flutter/material.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/viewmodels/views/checklist_view_model.dart';
import 'package:nomadic/ui/shared/defaults.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';
import 'package:nomadic/ui/widgets/checklist_view_bottomsheet.dart';
import 'package:provider/provider.dart';

class ChecklistListItem extends StatelessWidget {
  final ChecklistItem checklistItem;
  const ChecklistListItem(this.checklistItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var checklistViewModel = Provider.of<ChecklistViewModel>(context);

        checklistViewModel.showFloatingActionButton = false;

        var sheetController = showBottomSheet(
            context: context,
            builder: (context) => ChecklistViewBottomSheet(this.checklistItem));
        sheetController.closed.then((value) {
          checklistViewModel.showFloatingActionButton = true;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            _buildFirstSection(),
            UIHelper.horizontalSpaceSmall,
            Expanded(child: _buildSecondSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstSection() {
    return CircleAvatar(
      backgroundColor: Colors.grey[400],
      foregroundColor: Colors.white,
      backgroundImage: this.checklistItem.hasPhotos()
          ? AssetImage(this.checklistItem.getPhotos()[0])
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
          Text(this.checklistItem.name,
              style: Styles.textDefault, overflow: TextOverflow.ellipsis),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildSecondSectionCameraIcon(),
              UIHelper.horizontalSpaceVerySmall,
              Text(
                "${this.checklistItem.category} | x${this.checklistItem.quantity}",
                style: Styles.textSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSecondSectionCameraIcon() {
    if (this.checklistItem.hasPhotos())
      return Icon(Icons.camera_alt, color: Colors.grey[400], size: 14.0);
    return Container();
  }
}
