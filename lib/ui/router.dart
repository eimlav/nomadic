import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/ui/views/checklist_delete_view.dart';
import 'package:nomadic/ui/views/checklist_edit_view.dart';
import 'package:nomadic/ui/views/checklist_photo_view.dart';
import 'package:nomadic/ui/views/checklist_view.dart';
import 'package:nomadic/ui/views/home_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Checklist:
        return MaterialPageRoute(builder: (_) => ChecklistView());
      case RoutePaths.ChecklistEdit:
        var checklistItem = settings.arguments as ChecklistItem;
        return MaterialPageRoute(
            builder: (_) => ChecklistEditView(checklistItem));
      case RoutePaths.ChecklistDelete:
        var checklistItem = settings.arguments as ChecklistItem;
        return MaterialPageRoute(
            builder: (_) => ChecklistDeleteView(checklistItem));
      case RoutePaths.ChecklistPhoto:
        var checklistItem = settings.arguments as ChecklistItem;
        return MaterialPageRoute(
            builder: (_) => ChecklistPhotoView(checklistItem));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
