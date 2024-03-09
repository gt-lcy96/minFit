import 'package:get/get.dart';
import 'package:min_fitness/api/api_client.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/controllers/home_controller.dart';
import 'package:min_fitness/controllers/meal_controller.dart';
import 'package:min_fitness/controllers/weight_controller.dart';
import 'package:min_fitness/repositories/exercise_repo.dart';
import 'package:min_fitness/repositories/food_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstant.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(() => ExerciseRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));

  Get.put(ExerciseController(exerciseRepo: Get.find()), permanent: true);
  Get.put(WeightController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(MealController(foodRepo: Get.find()), permanent: true);
}
