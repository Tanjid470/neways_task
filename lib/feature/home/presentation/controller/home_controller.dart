
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neways_task/feature/home/domain/quick_action_card_model.dart';

class HomeController extends GetxController{
  List<QuickActionCard> quickActionCardList = [
    QuickActionCard(title: "Attendance", mediaUrl: '', onTap: () {  }, icon: Icons.calendar_month_outlined),
    QuickActionCard(title: "Payslip", mediaUrl: '', onTap: () {  }, icon: Icons.payment),
    QuickActionCard(title: "Services", mediaUrl: '', onTap: () {  }, icon: Icons.miscellaneous_services),
    QuickActionCard(title: "Absent", mediaUrl: '', onTap: () {  }, icon: Icons.accessibility),
  ];


  var selectedPage = 0.obs;
  void changePage(int value) {
    selectedPage.value = value;
  }
}