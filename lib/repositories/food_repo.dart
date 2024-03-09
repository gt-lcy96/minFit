import 'package:get/get.dart';
import 'package:min_fitness/api/api_client.dart';

class FoodRepo {
    final ApiClient apiClient;

    FoodRepo({required this.apiClient});

    Future<Response> searchFoodList(keyword) async {
      Response data = await apiClient.postData('/api/meal/meal_predict_calories', {'keyword': keyword});
      return data;
    }
}