import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import 'components/oath.dart';
import 'components/openpgp.dart';
import 'components/piv.dart';
import 'components/settings.dart';
import 'generated/l10n.dart';
import 'home.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () => doRoute(context, Home.routeName),
            leading: Icon(Icons.home, color: Colors.black),
            title: Text(S.of(context).home, style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          ),
          ListTile(
            onTap: () => doRoute(context, OpenPGP.routeName),
            leading: Icon(Icons.lock, color: Colors.black),
            title: Text('OpenPGP', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          ),
          ListTile(
            onTap: () => doRoute(context, PIV.routeName),
            leading: Icon(Icons.credit_card, color: Colors.black),
            title: Text('PIV', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          ),
          ListTile(
            onTap: () => doRoute(context, OATH.routeName),
            leading: Icon(Icons.timer, color: Colors.black),
            title: Text('TOTP / HOTP', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: Icon(Icons.web, color: Colors.black),
          //   title: Text('WebAuthn', style: TextStyle(color: Colors.black)),
          //   trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          // ),
          ListTile(
            onTap: () => doRoute(context, Settings.routeName),
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text(S.of(context).settings, style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void doRoute(BuildContext context, String name) {
    if (NavigationHistoryObserver().top!.settings.name != name)
      Navigator.pushReplacementNamed(context, name);
    else
      Navigator.pop(context);
  }
}
