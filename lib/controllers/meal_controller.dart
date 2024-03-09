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
        print("_searchedFoodList:  ${_searchedFoodList}");
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
