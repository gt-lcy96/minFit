import 'package:get/get.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => ExerciseController());
}
