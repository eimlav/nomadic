import 'package:flutter/material.dart';
import 'package:nomadic/core/viewmodels/views/checklist_view_model.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/checklist.dart';

class ChecklistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistViewModel>(
        model: ChecklistViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('checklist'),
              ),
              floatingActionButton: model.showFloatingActionButton
                  ? ChecklistAddFloatingActionButton()
                  : Container(),
              body: SafeArea(
                child: Container(
                    padding: Styles.screenContentPadding,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Checklist(),
                        )
                      ],
                    )),
              ),
            ));
  }
}

class ChecklistAddFloatingActionButton extends StatefulWidget {
  @override
  _ChecklistAddFloatingActionButtonState createState() =>
      _ChecklistAddFloatingActionButtonState();
}

class _ChecklistAddFloatingActionButtonState
    extends State<ChecklistAddFloatingActionButton> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return _show
        ? FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Theme.of(context).buttonColor,
            ),
            onPressed: () {
              // var sheetController = showBottomSheet(
              //     context: context,
              //     builder: (context) => ChecklistViewBottomSheet());

              // showButton(false);

              // sheetController.closed.then((value) {
              //   showButton(true);
              // });
            },
          )
        : Container();
  }

  void showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}