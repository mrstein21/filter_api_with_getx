import 'package:basic_flutter/mixins/routes/initial_binding.dart';
import 'package:basic_flutter/mixins/routes/routes.dart';
import 'package:basic_flutter/mixins/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('id', 'ID'),
        theme: ThemeData(
          primaryColor: kColorWhite
        ),
        initialRoute: homeRoute,
        initialBinding: InitialBinding(),
        getPages: routePage,
        debugShowCheckedModeBanner: false,
    );
  }
}

