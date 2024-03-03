import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/widgets/tag.dart';

class WorkoutSlider extends StatefulWidget {
  const WorkoutSlider({super.key});

  @override
  State<WorkoutSlider> createState() => _WorkoutSliderState();
}

class _WorkoutSliderState extends State<WorkoutSlider> {
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(builder: (exerciseController) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: exerciseController.isLoaded
                ? CarouselSlider.builder(
                    itemCount: exerciseController.bodyPartList.length,
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 200,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index.toDouble();
                          });
                        }),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(exerciseController
                                  .bodyPartList[itemIndex].gifUrl),
                              fit: BoxFit.cover)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            tag(exerciseController.bodyPartList[itemIndex].name,
                                AppColors.primaryLightColor),
                          ]),
                    ),
                  )
                : CircularProgressIndicator(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: exerciseController.bodyPartList.length <= 0
                  ? 1
                  : exerciseController.bodyPartList.length,
              position: currentIndex,
              decorator: DotsDecorator(
                activeColor: AppColors.primaryLightColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      );
    });
  }
}
