import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mouvour_getx/controllers/theme/theme_controller.dart';
import 'package:mouvour_getx/views/Details/details.dart';
import 'package:mouvour_getx/views/Homepage/homepage.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) => HomePage(),
      routes: [
        GoRoute(
          path: 'details/:id',
          name: 'details',
          builder: (context, state) => DetailsPage(id: state.params['id'],),
        )
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = ThemeController();
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme:
          themeController.isDark.value ? ThemeData.dark() : ThemeData.light(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
