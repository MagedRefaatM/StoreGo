import 'package:store_go/verification/business_logic_layer/verification_cubit.dart';
import 'package:store_go/verification/presentation_layer/verification_page.dart';
import 'package:store_go/page_view/view/new_invoice.dart';
import 'package:store_go/page_view/view/page_view.dart';
import 'package:store_go/settings/view/settings.dart';
import 'login/business_logic_layer/login_cubit.dart';
import 'login/presentation_layer/login_page.dart';
import 'package:store_go/splash/splash_page.dart';
import 'package:store_go/store/view/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'orders/view/orders.dart';

class AppRouter {
  final BuildContext context;
  AppRouter(this.context);

  final initialRoute = SplashPage();

  final Map<String, Widget Function(BuildContext)> routes = {
    '/splash_page': (context) => SplashPage(),
    '/login_page': (context) => BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(), child: LoginPage()),
    '/verification_page': (context) => BlocProvider<VerificationCubit>(
        create: (context) => VerificationCubit(), child: VerificationPage()),
    '/page_view_controller': (context) => PageViewController(),
    '/new_requests_page': (context) => NewInvoice(),
    '/requests_page': (context) => Orders(),
    '/store_page': (context) => Store(),
    'setting_page': (context) => Settings()
  };

  MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    Widget Function(BuildContext) builder = routes[name];
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
