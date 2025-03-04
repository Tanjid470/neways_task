import 'package:flutter/material.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/config/responsive_scale.dart';
import 'package:neways_task/const/app_colors.dart';

class LeaveStatusCard extends StatelessWidget {
  const LeaveStatusCard({
    super.key,
    required this.icon,
    required this.title,
    required this.days,
  });


  final IconData icon;
  final String title;
  final String days;

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: ResponsiveScale.of(context).hp(1),
        children: [
          Icon(icon,color: AppColor.blackColor,),
          Text(title,style: TextStyle(fontSize: TextSize.font14(context),color: AppColor.baseColor,fontWeight: FontWeight.w800)),
          CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.baseColorShadow,
              child:Text(days,style: TextStyle(fontSize: TextSize.font28(context),fontWeight: FontWeight.bold,color: AppColor.blackColor),)
          )
        ]
    );
  }
}
