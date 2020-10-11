import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamger/pages/home.dart';
import 'package:zamger/store/news_controller.dart';
import 'package:zamger/utils/colors.dart';

void main() {
  runApp(GetMaterialApp(
      title: 'Zamger',
      theme: ThemeData(
        primaryColor: PRIMARY_BACKGROUND,
        scaffoldBackgroundColor: PRIMARY_BACKGROUND,
      ),
      initialRoute: '/home',
      onInit: () {
        Get.put(NewsController());
      },
      getPages: [
        GetPage(
          name: "/home",
          page: () => Home(),
        ),
      ]));
}
