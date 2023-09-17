import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/global.dart';
import 'package:medicen_app/utils/my_string.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language/localiztion.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: false,
      ),
      locale: Locale(GetStorage().read<String>('language').toString()),
      translations: LocaliztionApp(),
      fallbackLocale: Locale(ene),
      initialRoute: Routes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
