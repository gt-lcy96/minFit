import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:min_fitness/models/food_model.dart';
import 'package:min_fitness/repositories/food_repo.dart';

class MealController extends GetxController {
  MealController({required this.foodRepo});
  final FoodRepo foodRepo;

  bool _foodListIsSearched = false;
  bool get foodListIsSearched => _foodListIsSearched;

  List<FoodModel> _searchedFoodList = [];
  List<FoodModel> get searchedFoodList => _searchedFoodList;

  String _selectedMeal = "";
  String get selectedMeal => _selectedMeal;

  double _caloriesConsumed = 0;
  double get calcoriesConsumed => _caloriesConsumed;

  final Map<String, List<FoodModel>?> _meal = {
    'breakfast': [],
    'lunch': [],
    'dinner': [],
    'snack': [],
  };
  Map<String, List<FoodModel>?> get meal => _meal;

  addMeal(String meal_name, FoodModel food) {
    _meal[meal_name]!.add(food);
    _caloriesConsumed += food.calories;
    update();
  }

  set selectedMeal (String meal){
    _selectedMeal = meal;
    update();
  }

  seacrhFoodList(keyword) async {
    try {
      _foodListIsSearched = false;
      Response response = await foodRepo.searchFoodList(keyword);
      if (response.statusCode == 200) {
        final foodList = response.body['data']['food_list'] as List;
        // final jsonResponse = json.decode(response.body);
        _searchedFoodList = foodList
            .map((e) => FoodModel.fromMap(e as Map<String, dynamic>))
            .toList();
        update();
      } else {
        print(response.statusCode);
        if (kDebugMode) {
          print("response.body:  ${response.body}");
        }
      }
      // final decoded_json = json.decode(jsonResponse);
    } catch (e) {
      print('Error in searchFoodList: ' + e.toString());
    } finally {
      _foodListIsSearched = true;
    }
  }
}
