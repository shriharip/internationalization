import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internationalization/provider/translations_provider.dart';
import 'package:internationalization/pages/demo_page.dart';
import 'package:internationalization/utils/global_translations.dart';

import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<Translations>(
    builder: (context) => Translations(),
    child: Consumer<Translations>(
      builder: (context, trans, _) =>  StreamBuilder<Locale>(
        stream: trans.currentLocale,
        initialData: allTranslations.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {

          return MaterialApp(
            title: 'Application Title',

            ///
            /// Multi lingual
            ///
            locale: snapshot.data ?? allTranslations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: allTranslations.supportedLocales(),

            routes: {
              '/page2': (BuildContext context) => Page2(),
            },
            
            home: DemoPage(trans),
          );
        }
      ),
    )
    );
  }
}
   