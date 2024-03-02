import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/mock_data/exercise_list.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/widgets/exercise_card.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class Workout extends StatelessWidget {
  const Workout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0.h,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: Get.width,
                  height: Get.height * 0.5,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: ExerciseList().exercises.map((exercise) {
                      final exerciseContent = ExerciseModel.fromJson(json.encode(exercise));
                      return ExerciseCard(content:exerciseContent);
                    }).toList(),
                  ),
                ),
        
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: ShadowedCard(
                height: Get.height * 0.35,
                backgroundColor: AppColors.primaryLightColor.withOpacity(0.4),
              child: Text('testing'),
            )),
          ],
        ),
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
