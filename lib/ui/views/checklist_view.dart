import 'package:flutter/material.dart';
import 'package:nomadic/ui/shared/styles.dart';
import 'package:nomadic/ui/widgets/checklist.dart';

class ChecklistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('checklist'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
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
    );
  }
}
