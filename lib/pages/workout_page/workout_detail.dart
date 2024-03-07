import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';

class WorkoutDetail extends StatelessWidget {
  WorkoutDetail({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ExerciseController>(builder: (controller) {
        final exercise_detail = controller.getExerciseDetailByID(id!);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Workout Detail: ${id}'),
              Text('Workout bodyPart: ${exercise_detail!.bodyPart}'),
              Text('Workout equipment: ${exercise_detail!.equipment}'),
            ],
          ),
        );
      }),
    );
  }
}
