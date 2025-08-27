import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:expense_splitter/core/env_helper/env_helper.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_service.dart';
import 'package:expense_splitter/firebase_options.dart';
import 'package:expense_splitter/src/presentation/screens/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/bloc/authentication/authentication_bloc.dart';
import 'core/configs/router-configs/router.dart';
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initMain();
  runApp(const MainApp());
}

Future<void> _initMain() async {
  //firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //DI
  await initializeDependencies();

  //setting env
  await EnvHelper.init();
  //connecting db
  final result = await sl<MongoDbService>().openDb();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fitness Tracker',
      color: Color(0xFF1A237E),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white70,
          surface: Color(0xFF1A237E),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1344),

        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.white.withOpacity(0.1),
          backgroundColor: const Color(0xFF1A237E),
        ),
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
