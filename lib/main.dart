import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:store_go/verification/view/verification.dart';
import 'package:store_go/page_view/view/new_invoice.dart';
import 'package:store_go/page_view/view/page_view.dart';
import 'package:store_go/settings/view/settings.dart';
import 'package:store_go/orders/view/orders.dart';
import 'package:store_go/store/view/store.dart';
import 'package:store_go/splash/splash.dart';
import 'package:flutter/material.dart';
import 'locale/app_locale.dart';
import 'login/view/login.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/splash_page',
      routes: {
        '/splash_page': (context) => Splash(),
        '/login_page': (context) => Login(),
        '/verification_page': (context) => Verification(),
        '/page_view_controller': (context) => PageViewController(),
        '/new_requests_page': (context) => NewInvoice(),
        '/requests_page': (context) => Orders(),
        '/store_page': (context) => Store(),
        'setting_page': (context) => Settings()
      },
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    ));
