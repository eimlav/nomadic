import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/core/viewmodels/widgets/checklist_model.dart';
import 'package:nomadic/ui/views/base_widget.dart';
import 'package:nomadic/ui/widgets/checklist_listitem.dart';
import 'package:provider/provider.dart';

class Checklist extends StatelessWidget {
  const Checklist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChecklistModel>(
        model: ChecklistModel(dbService: Provider.of(context)),
        onModelReady: (model) => model.getChecklistItems(),
        builder: (context, model, child) => model.busy
            ? Center(
                child: SpinKitWave(color: Colors.red, size: 35.0),
              )
            : ListView.builder(
                itemCount: model.checklistItems.length,
                itemBuilder: (context, index) => ChecklistListItem(
                      model.checklistItems[index],
                      () {},
                      // post: model.posts[index],
                      // onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   RoutePaths.Post,
                      //   arguments: model.posts[index],
                      // );
                      // },
                    ),
              ));
  }
}
