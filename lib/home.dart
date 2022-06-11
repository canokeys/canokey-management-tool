import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(S.of(context).homePress, style: TextStyle(fontSize: 18.0)),
                SizedBox(width: 5.0),
                Icon(Icons.menu, color: Colors.black, size: 22.0),
                SizedBox(width: 5.0),
                Text(S.of(context).homeSelect, style: TextStyle(fontSize: 18.0)),
              ],
            ),
            SizedBox(height: 50.0),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://console-legacy.canokeys.org')),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Text('Use Old Version', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        )
      ),
    );
  }
}
