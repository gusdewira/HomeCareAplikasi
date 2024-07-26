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
  // init flutter, to make sure all the widgets are ready
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // init lazyui
  LazyUi.config(alwaysPortrait: true);

  // init shared preferences
  prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // init dio, we customize it with the name "fetchly"
  Fetchly.init(
      baseUrl: 'https://homecare.galkasoft.id/api/',
      onRequest: RequestHandler.onRequest);

  dio.setToken(token);

  // NOTE: kamu juga bisa membuat file sendiri untuk menjalankan kode pada bagian ini
  // sehingga file main.dart ini terlihat lebih bersih

  // init provider and run app
  runApp(const ProviderScope(child: MyApp()));
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
