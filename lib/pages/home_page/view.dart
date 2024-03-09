import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/home_controller.dart';
import 'package:min_fitness/pages/diet_page/view.dart';
import 'package:min_fitness/pages/main_dashboard/view.dart';
import 'package:min_fitness/pages/more_page/view.dart';
import 'package:min_fitness/pages/workout_page/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late PersistentTabController _controller;

  List pages = [
    const MainDashboardPage(),
    const DietPage(),
    const Workout(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: pages[controller.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          selectedItemColor: AppColors.primaryLightColor,
          unselectedItemColor: AppColors.primaryDarkColorDark,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          onTap: (index) {
            controller.selectedIndex = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lunch_dining),
              label: "diet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: "workout",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "more",
            ),
          ],
        ),
      );
    });
  }
}
