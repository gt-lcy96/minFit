import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/pages/home_page/view.dart';
import 'package:min_fitness/pages/main_dashboard/view.dart';

import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // GetPage(
    //   name: AppRoutes.INITIAL,
    //   page: () => const DataUploaderScreen(),
    //   binding: DataUploaderBinding(),
    //   customTransition: CustomScaleTransition(),
    //   transitionDuration: Duration(milliseconds: 500),
    // ),

    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const HomePage(),
      transitionDuration: Duration(milliseconds: 500),
    ),
    // GetPage(
      // name: AppRoutes.HOME,
      // name: AppRoutes.HOME,
      // page: () => const HomePage(),
      // binding: BindingsBuilder(() {
      //   Get.put(QuestionPaperController());
      //   Get.put(MyZoomDrawerController());
      // }),
      // customTransition: CustomScaleTransition(),
      // transitionDuration: Duration(milliseconds: 500),
  ];
}
