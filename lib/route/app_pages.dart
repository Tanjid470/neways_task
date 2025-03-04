
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:neways_task/feature/home/presentation/home_view.dart';
import 'package:neways_task/main.dart';
part 'app_routes.dart';
class AppPages{
  AppPages._();

  static String INITIAL = isInitScreen == 0 || isInitScreen == null
      ? Routes.homeScreen
      : Routes.homeScreen;
  static final routes =[
    GetPage(
      name:_Paths.homeScreen,
      page: () => const HomeView(),
      transition: Transition.leftToRight,
      curve: Curves.fastOutSlowIn,
    ),
  ];
}