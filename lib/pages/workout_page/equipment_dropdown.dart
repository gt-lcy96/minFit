import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class EquipmentDropDownButton extends StatelessWidget {
  // Determine the current value for the dropdown

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(builder: (controller) {
      String dropdownValue = controller.selected_equipment;
      if (dropdownValue.isEmpty && controller.exerciseDisplayList!.isNotEmpty) {
        dropdownValue = controller.exerciseDisplayList![0].equipment;
      } else if (dropdownValue.isEmpty) {
        dropdownValue =
            'body weight'; // This should be a valid, unique default value
      }

      List<DropdownMenuItem<String>> menuItems = controller.exerciseDisplayList!
          .map((exercise) => exercise.equipment)
          .toSet() // Remove duplicates
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();

      print("dropdownValue:  ${dropdownValue}");
      // assert(menuItems.any((item) => item.value == dropdownValue));

      return controller.equipmentIsSelected
          ? ShadowedCard(
              height: Get.height * 0.06,
              // width: Get.width * 0.42,
              width: Get.width * 0.9,
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
                    controller.setSelectedEquipment(value!);
                  },
                  items: menuItems,
                ),
              ),
            )
          : Container();
    });
  }
}
