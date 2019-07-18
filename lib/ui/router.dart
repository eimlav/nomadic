import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/ui/views/checklist_view.dart';
import 'package:nomadic/ui/views/home_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Checklist:
        return MaterialPageRoute(builder: (_) => ChecklistView());
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
