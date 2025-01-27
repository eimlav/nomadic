import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/shared/ui_helper.dart';

class ChecklistViewBottomSheet extends StatefulWidget {
  final ChecklistItem checklistItem;

  ChecklistViewBottomSheet(this.checklistItem);

  @override
  _ChecklistViewBottomSheetState createState() =>
      _ChecklistViewBottomSheetState();
}

class _ChecklistViewBottomSheetState extends State<ChecklistViewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double headingWidth = screenWidth * 0.25;

    return Container(
        color: Colors.red,
        width: screenWidth,
        padding: Styles.screenContentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: headingWidth,
                    child: Text('name', style: Styles.textSmallContrast)),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                    child: Text(widget.checklistItem.name,
                        style: Styles.textDefaultContrast,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 3)),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: headingWidth,
                    child: Text('quantity', style: Styles.textSmallContrast)),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                    child: Text(widget.checklistItem.quantity.toString(),
                        style: Styles.textDefaultContrast,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right)),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: headingWidth,
                    child: Text('category', style: Styles.textSmallContrast)),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                    child: Text(widget.checklistItem.category,
                        style: Styles.textDefaultContrast,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 2)),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: headingWidth,
                    child: Text('photos', style: Styles.textSmallContrast)),
                FlatButton(
                    onPressed: () => {
                          Navigator.pushNamed(
                              context, RoutePaths.ChecklistPhoto,
                              arguments: widget.checklistItem)
                        },
                    child: Text("Open",
                        style: Styles.textLink,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right)),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            widget.checklistItem.description != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: headingWidth,
                          child: Text('description',
                              style: Styles.textSmallContrast)),
                      UIHelper.horizontalSpaceSmall,
                      Expanded(
                          child: Text(
                        widget.checklistItem.description,
                        style: Styles.textDefaultContrast,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 50,
                      )),
                    ],
                  )
                : Container(),
            UIHelper.verticalSpaceMedium,
            Builder(
              builder: (BuildContext context) {
                return FlatButton(
                    color: Colors.grey[200],
                    textTheme: ButtonTextTheme.accent,
                    splashColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.5))),
                    onPressed: () async {
                      await Navigator.pushNamed(
                        context,
                        RoutePaths.ChecklistEdit,
                        arguments: widget.checklistItem,
                      );
                    },
                    child: Text('Edit', style: Styles.textButtonContrast));
              },
            ),
          ],
        ));
  }
}
