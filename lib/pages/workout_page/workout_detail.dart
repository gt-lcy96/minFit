import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/controllers/weight_controller.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/pages/workout_page/view.dart';
import 'package:min_fitness/widgets/appIcon_text.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:min_fitness/widgets/shadow_card_no_height.dart';

class WorkoutDetail extends StatelessWidget {
  WorkoutDetail({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            )),
      ),
      body: GetBuilder<ExerciseController>(builder: (controller) {
        final exercise_detail = controller.getExerciseDetailByID(id!);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShadowedCard(
                  height: 200.h,
                  width: 300.w,
                  backgroundColor: AppColors.onSurfaceTextColor,
                  child: networkImage(
                      '${AppConstant.BASE_URL}/api/exercise/static/gifs/${exercise_detail!.gifUrl}')),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ShadowedCardNoHeight(
                    backgroundColor: AppColors.onSurfaceTextColor,
                    // height: Get.height * 0.4,
                    width: Get.width,
                    child: Column(
                      children: [
                        Text(
                          '${exercise_detail.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),

                            // bodyPart
                            AppIconText(
                                icon: Icon(
                                  Icons.accessibility_new,
                                  size: 50,
                                ),
                                text: textRow(
                                    'Body Part: ', exercise_detail.bodyPart)),
                            columnDivider(),
                            // equipment
                            AppIconText(
                                icon: Icon(
                                  Icons.fitness_center,
                                  size: 50,
                                ),
                                text: textRow(
                                    'Equipment: ', exercise_detail.equipment)),
                            columnDivider(),
                            // Train target
                            AppIconText(
                                icon: Icon(
                                  Icons.outlined_flag,
                                  size: 50,
                                ),
                                text: textRow(
                                    'Train Target: ', exercise_detail.target)),
                            columnDivider(),
                            // Train target
                            AppIconText(
                                icon: Icon(
                                  Icons.local_fire_department,
                                  size: 50,
                                ),
                                text: textRow(
                                    'Calories / hour: ',
                                    (exercise_detail.metValue *
                                            Get.find<WeightController>()
                                                .weight *
                                            1)
                                        .toStringAsFixed(2)
                                    // exercise_detail.metValue.toString(),
                                    )),
                            SizedBox(height: 10.h),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AddExerciseButton(context, exercise_detail),
                                ],
                              ),
                            )
                          ],
                        )),
                      ],
                    )),
              ),
              // Text('Workout bodyPart: ${exercise_detail!.bodyPart}'),
              // Text('Workout equipment: ${exercise_detail!.equipment}'),
            ],
          ),
        );
      }),
    );
  }
}

Widget columnDivider() {
  return Divider(
    height: 10.h,
    indent: 10.w,
    endIndent: 10.w,
  );
}

Widget textRow(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: Get.width * 0.3,
        child: Text(
          title,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Container(
        width: Get.width * 0.4,
        child: Text(
          description,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ],
  );
}

Widget AddExerciseButton(BuildContext context, ExerciseModel exercise_detail) {
  return InkWell(
    onTap: () {
      pick_time(context, exercise_detail);
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 60.w),
      child: Text(
        'Add Exercise',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLightColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    ),
  );
}

pick_time(BuildContext context, ExerciseModel exercise_detail) {
  BottomPicker.time(
    title: 'Select your exercise time',
    titleStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.orange,
    ),
    onSubmit: (datetime) {
      final minute = Duration(minutes: (datetime as DateTime).minute);
      final totolHour = (Duration(hours: (datetime as DateTime).hour) + minute);
      Get.find<ExerciseController>().exerciseDuration = totolHour;
      Get.find<ExerciseController>().calories_burned = exercise_detail.metValue *
          Get.find<WeightController>().weight *
          (totolHour.inMinutes / 60);
      Get.snackbar(
                'Success Added',
                'Exercise Duration Is Successfully Added',
                backgroundColor: Colors.green, // Optional: set background color
                colorText: Colors.white, // Optional: set text color
                duration: Duration(seconds: 2), // Optional: set duration
              );
    },
    onClose: () {
      print('Picker closed');
    },
    bottomPickerTheme: BottomPickerTheme.orange,
    use24hFormat: true,
    initialTime: Time(
      minutes: 30,
    ),
    maxTime: Time(
      hours: 23,
      minutes: 59,
    ),
  ).show(context);
}
