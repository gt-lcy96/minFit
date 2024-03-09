import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/meal_controller.dart';
import 'package:min_fitness/mock_data/food_list.dart';
import 'package:min_fitness/models/food_model.dart';
import 'package:min_fitness/routes/names.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:min_fitness/widgets/shadow_card_no_height.dart';

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MealController>(builder: (controller) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: Get.width,
              // height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  addFoodContent('Breakfast', controller.meal['breakfast'], controller),
                  SizedBox(
                    height: 20.h,
                  ),
                  addFoodContent('Lunch', controller.meal['lunch'], controller),
                  SizedBox(
                    height: 20.h,
                  ),
                  addFoodContent('Dinner', controller.meal['dinner'], controller),
                  SizedBox(
                    height: 20.h,
                  ),
                  addFoodContent('Snack', controller.meal['snack'], controller),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget addFoodContent(String title, List<FoodModel>? foodList, MealController controller) {
  double totalCalories = 0;

  double calculate_totalCatories(List<FoodModel>? foodList) {
    for (var food in foodList!) {
      totalCalories += food.calories as double;
    }
    return totalCalories;
  }

  totalCalories = foodList!.isNotEmpty ? calculate_totalCatories(foodList) : 0;

  return ShadowedCardNoHeight(
      width: (Get.width * 0.7).w,
      // height: null,
      backgroundColor: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryLightColor,
                        radius: 20,
                        child: IconButton(
                            onPressed: () {
                              controller.selectedMeal = title.toLowerCase();
                              Get.toNamed(AppRoutes.SEARCH_FOOD);
                            },
                            icon: Icon(Icons.add),
                            color: AppColors.onSurfaceTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ColoredText(
                      text: title,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                totalCalories > 0
                    ? Container(
                        child: Text(
                          totalCalories.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 5.h),
            horizontalDiv(),
            SizedBox(height: 5.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                // Define a maximum height for the ListView
                maxHeight: 100.h, // Adjust this value as needed
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String food = foodList[index].name ?? '';
                  String serving_size = foodList[index].serving_size ?? '';
                  String calories = foodList[index].calories.toString() ?? '';

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColoredText(
                            text: food,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          Text(serving_size),
                        ],
                      ),
                      Text(calories),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: foodList.length,
              ),
            ),
          ]));
}

Widget horizontalDiv() {
  return Divider(
    color: Colors.grey,
    thickness: 2,
    height: 5,
    // indent: 10,
    // endIndent: 10,
  );
}
