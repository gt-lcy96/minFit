import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/widgets/tag.dart';

class WorkoutSlider extends StatelessWidget {
  const WorkoutSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(builder: (exerciseController) {
      return exerciseController.isLoaded
          ? CarouselSlider.builder(
              itemCount: exerciseController.bodyPartList.length,
              options: CarouselOptions(enlargeCenterPage: true, height: 200),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            exerciseController.bodyPartList[itemIndex].gifUrl),
                        fit: BoxFit.cover)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tag(exerciseController.bodyPartList[itemIndex].name,
                          AppColors.primaryLightColor),
                    ]),
              ),
            )
          : CircularProgressIndicator();
    });
  }
}
