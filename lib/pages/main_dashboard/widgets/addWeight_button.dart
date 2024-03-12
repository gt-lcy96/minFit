import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/weight_controller.dart';
import 'package:intl/intl.dart';
import 'package:min_fitness/models/weight_model.dart';

Widget addWeightButton(BuildContext context) {
  return InkWell(
    onTap: () {
      // Get.toNamed(AppRoutes.ADD_WEIGHT);
      // Get.dialog(weightDialog());
      Get.bottomSheet(weightBottomSheet(context));
    },
    child: Container(
      height: 45.h,
      width: 45.w,
      child: Icon(
        Icons.add,
        color: AppColors.onSurfaceTextColor,
      ),
    ),
  );
}

Widget weightBottomSheet(BuildContext context) {
  TextEditingController textController = TextEditingController();

  return GetBuilder<WeightController>(builder: (controller) {
    final date = DateFormat('d MMMM yyyy').format(controller.created_at);
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close)),
                  ),
                  Text(
                    'Add Weight',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                          final inputModel = WeightModel(date: controller.created_at, weight: controller.weight);
                          controller.submitWeight(inputModel);
                          controller.sortByDate();
                        },
                        child: Icon(Icons.check)),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Weight', style: titleStyle()),
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          child: TextField(
                            controller: textController,
                            onChanged: (String text) {
                              controller
                                  .setWeight(textController.text);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: controller.weight.toString(),
                                border: InputBorder.none),
                          ),
                        ),
                        // Text('75', style: descriptionStyle()),
                        Text('kg', style: descriptionStyle()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date', style: titleStyle()),
                    InkWell(
                        onTap: () {
                        show_date_picker(context);
                        },
                        child: Text(date, style: descriptionStyle())),
                  ],
                ),
              ),
            ],
          )),
    );
  });
}

TextStyle titleStyle() {
  return TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}

TextStyle descriptionStyle() {
  return TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
}

show_date_picker(BuildContext context) {
  BottomPicker.date(
          title: "Select the date",
          maxDateTime: DateTime.now(),
          titleStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue),
          onChange: (index) {
            // print(index);
          },
          onSubmit: (index) {
            // print("index.runtimeType:  ${index.runtimeType}");
            // final datetime = DateTime.parse(index);
            Get.find<WeightController>().setCreatedAt(index);
            print(
                "Get.find<WeightController>().created_at:  ${Get.find<WeightController>().created_at}");
          },
          bottomPickerTheme: BottomPickerTheme.plumPlate)
      .show(context);
}
