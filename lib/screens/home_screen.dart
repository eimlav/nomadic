import 'package:flutter/material.dart';

import '../styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return [_buildListButton('Checklist', Icons.list, () {})];
  }

  Widget _buildListButton(String title, IconData icon, Function callback) {
    return FlatButton(
        highlightColor: Colors.grey[200],
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        onPressed: callback,
        child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              Icon(icon),
              Container(width: 10.0),
              Text(title, style: Styles.headerLarge, textAlign: TextAlign.left)
            ])));
  }
}
