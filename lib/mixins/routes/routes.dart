import 'package:basic_flutter/ui/home/home_binding.dart';
import 'package:basic_flutter/ui/home/home_screen.dart';
import 'package:get/get.dart';

const homeRoute="/home";

var routePage=[
  GetPage(
      binding: HomeBinding(),
      name: homeRoute,
      page: ()=>HomeScreen()
  )
];