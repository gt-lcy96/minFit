import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/pages/add_weight_page/view.dart';
import 'package:min_fitness/routes/routes.dart';

Widget addWeightButton() {
  return InkWell(
    onTap: () {
      // Get.toNamed(AppRoutes.ADD_WEIGHT);
      // Get.dialog(weightDialog());
      Get.bottomSheet(weightBottomSheet());
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

Widget weightBottomSheet() {
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
                  child: InkWell(onTap: () {
                    Get.back();
                  }, child: Icon(Icons.close)),
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
                  child: InkWell(onTap: () {
                    Get.back();
                  }, child: Icon(Icons.check)),
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
                      Text('75', style: descriptionStyle()),
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
                  Text('3 March 2024', style: descriptionStyle()),
                ],
              ),
            ),
          ],
        )),
  );
}

TextStyle titleStyle() {
  return TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}

TextStyle descriptionStyle() {
  return TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
}

Widget textRow(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: Get.width * 0.3,
        child: Text(
          title,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Container(
        width: Get.width * 0.4,
        child: Text(
          description,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ],
  );
}
