import 'package:get/get.dart';
import 'package:min_fitness/api/api_client.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:min_fitness/models/exercise_model.dart';

class ExerciseRepo {
    final ApiClient apiClient;

    ExerciseRepo({required this.apiClient});

    Future<Response> getExerciseList() async {
      return await apiClient.getData(AppConstant.BASE_URL + 'api/exercise/exercise_list');
    }
}