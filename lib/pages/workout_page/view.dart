import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/mock_data/exercise_list.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/pages/workout_page/workout_slider.dart';
import 'package:min_fitness/widgets/exercise_card.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class Workout extends StatelessWidget {
  const Workout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ExerciseController>(builder: (exerciseController) {
          return Stack(
            children: [
              Positioned(
                bottom: 0.h,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: Get.width,
                  height: Get.height * 0.4,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: exerciseController.isLoaded
                        ? exerciseController.exerciseList!
                            .where((ExerciseModel e) =>
                                e.bodyPart ==
                                exerciseController
                                    .bodyPartList[
                                        exerciseController.slider_index]
                                    .name)
                            .map((exercise) {
                            // print("exercise:  ${exercise}");
                            // final exerciseContent =
                            //     ExerciseModel.fromJson(json.encode(exercise));
                            return ExerciseCard(content: exercise);
                          }).toList()
                        : [CircularProgressIndicator()],
                  ),
                ),
              ),
              Positioned(
                  top: Get.width * 0.3,
                  left: 20,
                  right: 20,
                  child: ShadowedCard(
                    height: Get.height * 0.25,
                    backgroundColor:
                        AppColors.primaryLightColor.withOpacity(0.4),
                    child: Container(
                      child: WorkoutSlider(),
                    ),
                  )),
              Positioned(
                  top: Get.width * 0.1,
                  left: 20,
                  right: 20,
                  child: ShadowedCard(
                    height: 60,
                    width: Get.width * 0.8,
                    child: Container(),
                    // child: Center(child: Text('Search')),
                    backgroundColor: Colors.white,
                  ))
            ],
          );
        }),
      ),
    );
  }
}

Widget networkImage(String imgUrl) {
  return Image.network(
    imgUrl, // Replace this URL with the actual URL of the image
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      }
    },
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Text('Image could not be loaded.');
    },
  );
}
