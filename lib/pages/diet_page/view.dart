import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/mock_data/food_list.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:min_fitness/widgets/shadow_card_no_height.dart';

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                addFoodContent('Breakfast', FoodList().breakfastList),
                SizedBox(
                  height: 20.h,
                ),
                addFoodContent('Lunch', FoodList().lunchList),
                SizedBox(
                  height: 20.h,
                ),
                addFoodContent('Dinner', FoodList().dinnerList),
                SizedBox(
                  height: 20.h,
                ),
                addFoodContent('Snack', FoodList().snackList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget addFoodContent(String title, List<dynamic> foodList) {
  double totalCalories = 0;

  double calculate_totalCatories(List<dynamic> foodList) {
    for (var food in foodList) {
      totalCalories += food['calories'] as double;
    }
    return totalCalories;
  }

  totalCalories = calculate_totalCatories(foodList);

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
                            onPressed: () {},
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
                  String food = foodList[index]['food'] ?? '';
                  return Text(food);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 5.h,
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
