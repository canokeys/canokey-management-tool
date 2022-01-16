import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:logging/logging.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import 'components/oath.dart';
import 'components/openpgp.dart';
import 'components/settings.dart';
import 'generated/l10n.dart';
import 'home.dart';
import 'routes.dart';

main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
          onGenerateTitle: (context) => S.of(context).homeScreenTitle,
          theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
          debugShowCheckedModeBanner: false,
          home: Home(),
          navigatorObservers: [NavigationHistoryObserver()],
          routes: {
            Routes.openpgp: (_) => OpenPGP(),
            Routes.settings: (_) => Settings(),
            Routes.oath: (_) => OATH(),
          },
        );
      },
      maximumSize: Size(1200.0, 2160.0),
      enabled: kIsWeb,
      backgroundColor: Colors.grey,
    );
  }
}
