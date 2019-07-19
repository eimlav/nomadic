import 'package:flutter/material.dart';
import 'package:nomadic/core/constants/app_constants.dart';
import 'package:nomadic/ui/shared/styles.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('nomadic'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: Styles.screenContentPadding,
        child: Column(
          children: _buildScrollViewItems(),
        ),
      ),
    );
  }

  List<Widget> _buildScrollViewItems() {
    return [
      _buildListButton('Checklist', Icons.list, () {
        Navigator.pushNamed(context, RoutePaths.Checklist);
      })
    ];
  }

  Widget _buildListButton(String title, IconData icon, Function callback) {
    return FlatButton(
        highlightColor: Colors.grey[200],
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        onPressed: callback,
        child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              Container(width: 10.0),
              Text(title, style: Styles.headerLarge, textAlign: TextAlign.left)
            ])));
  }
}
