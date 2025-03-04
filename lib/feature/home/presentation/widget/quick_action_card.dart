import 'package:flutter/material.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/config/responsive_scale.dart';
import 'package:neways_task/const/app_colors.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.mediaUrl,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final String mediaUrl;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04,vertical: 10),
      child: Column(
        spacing: ResponsiveScale.of(context).hp(1),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.baseColorShadow,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Icon(icon,size: TextSize.font30(context),color: AppColor.baseColor,)
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: TextSize.font12(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
