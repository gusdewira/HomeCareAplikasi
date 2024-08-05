import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lazyui/lazyui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'freelancer/core/constants/theme.dart';
import 'freelancer/core/helpers/request_helder.dart';
import 'freelancer/data/local/storage.dart';
import 'freelancer/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  await initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initializeApp() async {
  // Init LazyUi
  LazyUi.config(alwaysPortrait: true);

  // Init SharedPreferences
  prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Init Fetchly
  Fetchly.init(
    baseUrl: 'https://homecare.galkasoft.id/api/',
    onRequest: RequestHandler.onRequest,
  );

  // Set token if available
  if (token != null) {
    dio.setToken(token);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Home Care App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (BuildContext context, Widget? child) {
        return LazyUi.builder(context, child);
      },
    );
  }
}

class AuthService {
  Future<void> login(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
