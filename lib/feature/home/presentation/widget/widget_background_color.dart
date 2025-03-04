import 'package:flutter/material.dart';
import 'package:neways_task/const/app_colors.dart';


class WidgetBackgroundColor extends StatelessWidget {
  const WidgetBackgroundColor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.baseColorShadow,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: child,
    );
  }
}