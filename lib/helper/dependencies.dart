import 'package:get/get.dart';
import 'package:min_fitness/api/api_client.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/repositories/exercise_repo.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstant.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(() => ExerciseRepo(apiClient: Get.find()));

  Get.lazyPut(() => ExerciseController(exerciseRepo: Get.find()));
}
