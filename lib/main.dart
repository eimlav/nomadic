import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/ui/router.dart';
import 'package:provider/provider.dart';

import './styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'nomadic',
        theme: Styles.appTheme,
        initialRoute: RoutePaths.Home,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
