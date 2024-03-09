import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/controllers/meal_controller.dart';
import 'package:min_fitness/models/food_model.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class SearchFoodPage extends StatelessWidget {
  const SearchFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Breakfast'),
      ),
      body: GetBuilder<MealController>(
        builder: (controller) {
          return Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SearchField(controller),
                  controller.foodListIsSearched ? SearchDropDown(controller) : Container(),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

Widget SearchDropDown(MealController controller) {
  return Column(
    children: controller.searchedFoodList.map((e) => Container(
      child: DropDownRow(e),
    )).toList(),
  );
}

Widget DropDownRow(FoodModel food) {
  return Column(
    children: [
      Text(food.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
      Text(food.calories.toString(), style: TextStyle(fontSize: 14.sp),),
    ]
  );
}

Widget SearchField(MealController controller) {
  final TextEditingController _textController = TextEditingController();
  return ShadowedCard(
    height: 60,
    width: Get.width * 0.8,
    backgroundColor: Colors.white,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: Get.width * 0.8),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: TextField(
            onEditingComplete: () {
              controller.seacrhFoodList(_textController.text);
            },
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
            ),
          ),
        ),
        InkWell(
            onTap: () {
              controller.seacrhFoodList(_textController.text);
            },
            child: Icon(Icons.search)),
      ]),
    ),
  );
}
