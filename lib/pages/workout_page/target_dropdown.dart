import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class TargetDropDownButton extends StatelessWidget {
  // Determine the current value for the dropdown

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(builder: (controller) {
      String dropdownValue = controller.selected_target;
      if (dropdownValue.isEmpty && controller.exerciseDisplayList!.isNotEmpty) {
        dropdownValue = controller.exerciseDisplayList![0].target;
      } else if (dropdownValue.isEmpty) {
        dropdownValue =
            'body weight'; // This should be a valid, unique default value
      }

      List<DropdownMenuItem<String>> menuItems = controller.exerciseDisplayList!
          .map((exercise) => exercise.target)
          .toSet() // Remove duplicates
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();

      print("dropdownValue:  ${dropdownValue}");
      // assert(menuItems.any((item) => item.value == dropdownValue));

      return controller.targetIsSelected
          ? ShadowedCard(
              height: Get.height * 0.06,
              width: Get.width * 0.42,
              backgroundColor: AppColors.onSurfaceTextColor,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(color: Colors.grey),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  value: dropdownValue,
                  onChanged: (String? value) {
                    controller.setSelectedTarget(value!);
                  },
                  items: menuItems,
                ),
              ),
            )
          : Container();
    });
  }
}
