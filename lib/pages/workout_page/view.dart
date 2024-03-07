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
import 'package:min_fitness/pages/workout_page/equipment_dropdown.dart';
import 'package:min_fitness/pages/workout_page/target_dropdown.dart';
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
          var filteredExerciseDisplayList = exerciseController.filteredExerciseDisplayList;
          var currentExerciseDisplayList = filteredExerciseDisplayList!.isNotEmpty ? filteredExerciseDisplayList : exerciseController.exerciseDisplayList;

          return Stack(
            children: [
              // Search Field
              Positioned(
                  top: Get.height * 0.03,
                  left: 20,
                  right: 20,
                  child: SearchField()),
              //DropDown Left
              Positioned(
                top: Get.height * 0.11,
                left: 20,
                child: EquipmentDropDownButton(),
              ),
              //DropDown Right
              Positioned(
                top: Get.height * 0.11,
                right: 20,
                child: TargetDropDownButton(),
              ),
              // Slider
              Positioned(
                  top: Get.height * 0.19,
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

              //Card Grid
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
                        ? currentExerciseDisplayList!
                            .map((exercise) {
                            return ExerciseCard(content: exercise);
                          }).toList()
                        : [CircularProgressIndicator()],
                  ),
                ),
              ),
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

Widget SearchField() {
  final TextEditingController _textController = TextEditingController();
  return GetBuilder<ExerciseController>(builder: (exerciseController) {
    return ShadowedCard(
      height: 60,
      width: Get.width * 0.8,
      // child: Center(child: Text('Search')),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              exerciseController
                  .searchExerciseDisplayList(_textController.text);
            },
            child: Icon(Icons.search),
          ),
        ]),
      ),
    );
  });
}
