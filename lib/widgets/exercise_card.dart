import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/routes/pages.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/tag.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    this.child,
    this.height = 200,
    this.width = 200,
    this.radius = 20,
    this.paddingAll = 15,
    this.backgroundColor = AppColors.onSurfaceTextColor,
    required this.content,
  });

  final Widget? child;
  final double? height;
  final double? width;
  final double radius;
  final double paddingAll;
  final Color backgroundColor;
  final ExerciseModel content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.getWorkoutDetail(content.id as String));
      },
      child: Container(
          padding: EdgeInsets.all(paddingAll),
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading1.jpeg',
                image: '${AppConstant.BASE_URL}/api/exercise/static/gifs/${content.gifUrl}',
              ).image,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  tag(content.equipment, Colors.yellow.withOpacity(0.5)),
                  SizedBox(
                    width: 5.w,
                  ),
                  tag(content.target, AppColors.primaryLightColor.withOpacity(0.5)),
            ],
          )),
    );
  }
}
