import 'package:flutter/material.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/config/responsive_scale.dart';
import 'package:neways_task/const/app_colors.dart';

class AttendanceInfoWidget extends StatelessWidget {
  final Color color;
  final String title;
  final int days;

  const AttendanceInfoWidget({super.key,
    required this.color,
    required this.title,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: ResponsiveScale.of(context).hp(1),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: TextSize.font14(context),
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        //verticalGap(context, 1),
        Row(
         children: [
           Text(
             '$days',
             style: TextStyle(
               fontSize: TextSize.font16(context),
               color: AppColor.blackColor,
               fontWeight: FontWeight.w600,
             ),
           ),
           horizontalGap(context, 1),
           Text(
             days == 1 ? 'day' : 'days',
             style: TextStyle(
               fontSize: TextSize.font14(context),
               color: AppColor.blackColor,
               fontWeight: FontWeight.w600,
             ),
           ),
         ],
       )
      ],
    );
  }
}