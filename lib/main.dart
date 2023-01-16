import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_test_base/router/route_names.dart';
import 'package:riverpod_test_base/ui/login/login_screen.dart';
import 'package:riverpod_test_base/ui/main_screen/main_screen.dart';
import 'package:riverpod_test_base/ui/splash_screen/splash_screen.dart';

import 'core/data/database/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.initLibrary();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: goRouter,
      // home: const SignInScreen(),
    );
  }

  final GoRouter goRouter = GoRouter(
    initialLocation: "/",
    // routes: [
    //   GoRoute(
    //     path: "/",
    //     builder: (context, state) => const SplashScreen(),
    //   ),
    //   GoRoute(
    //     path: "/login",
    //     builder: (context, state) => const SignInScreen(),
    //   ),
    //   GoRoute(
    //     path: "/main/:userName",
    //     builder: (context, state) => MainScreen(
    //       userName: state.params['userName']!,
    //     ),
    //   ),
    // ],
    routes: [
      GoRoute(
        name: RouteNames.splashScreen,
        path: "/",
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            name: RouteNames.loginScreen,
            path: "login",
            builder: (context, state) => const SignInScreen(),
          ),
          GoRoute(
            name: RouteNames.mainScreen,
            path: "main/:userName",
            builder: (context, state) => MainScreen(
              userName: state.params["userName"]!,
            ),
          ),
        ],
      ),
    ],
  );
}
