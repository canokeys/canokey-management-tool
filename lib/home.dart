import 'package:flutter/material.dart';

import 'drawer.dart';
import 'generated/l10n.dart';

class Home extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text(S.of(context).homeScreenTitle, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Press', style: TextStyle(fontSize: 18.0)),
            SizedBox(width: 5.0),
            Icon(Icons.menu, color: Colors.black, size: 22.0),
            SizedBox(width: 5.0),
            Text('to select an applet', style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
