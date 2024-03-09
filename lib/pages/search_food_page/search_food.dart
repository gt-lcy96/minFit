import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/meal_controller.dart';
import 'package:min_fitness/helper/format_string.dart';
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
        title: GetBuilder<MealController>(builder: (controller) {
          return Text(capitalizeFirstLetter(controller.selectedMeal));
        }),
      ),
      body: GetBuilder<MealController>(builder: (controller) {
        return Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SearchField(controller),
                SizedBox(
                  height: 5.h,
                ),
                controller.foodListIsSearched
                    ? SearchDropDown(controller)
                    : Container(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget SearchDropDown(MealController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: controller.searchedFoodList
        .map((e) => Container(
              child: DropDownRow(e, controller),
            ))
        .toList(),
  );
}

Widget DropDownRow(FoodModel food, MealController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.h),
    width: Get.width * 0.9,
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            food.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${food.calories.toStringAsFixed(0)} cal, ",
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                food.serving_size.toString(),
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ]),
        Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryLightColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () {
                  controller.addMeal(controller.selectedMeal, food);
                  Get.snackbar("Food Added", "${food.name} added in ${controller.selectedMeal}");
                },
                child: Icon(Icons.add))),
      ],
    ),
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
