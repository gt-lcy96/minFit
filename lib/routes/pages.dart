import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/pages/home_page/view.dart';
import 'package:min_fitness/pages/main_dashboard/view.dart';
import 'package:min_fitness/pages/search_food_page/search_food.dart';
import 'package:min_fitness/pages/workout_page/workout_detail.dart';

import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];
  static String getWorkoutDetail(String id) =>
      '${AppRoutes.WORKOUT_DETAIL}?id=$id';
  static const SEARCH_FOOD = AppRoutes.SEARCH_FOOD;

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

    GetPage(
      name: AppRoutes.WORKOUT_DETAIL,
      page: () {
        final String id = Get.parameters['id'] as String;
        return WorkoutDetail(id: id);
      },
    ),

    GetPage(
      name: AppRoutes.SEARCH_FOOD,
      page: () => const SearchFoodPage(),
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
