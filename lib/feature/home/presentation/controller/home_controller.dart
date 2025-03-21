
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neways_task/feature/home/data/attendance_data_model.dart';
import 'package:neways_task/feature/home/data/user_info_model.dart';
import 'package:neways_task/feature/home/domain/quick_action_card_model.dart';
import 'package:neways_task/main.dart';



class HomeController extends GetxController{
  List<QuickActionCard> quickActionCardList = [
    QuickActionCard(title: "Attendance", mediaUrl: '', onTap: () {  }, icon: Icons.calendar_month_outlined),
    QuickActionCard(title: "Payslip", mediaUrl: '', onTap: () {  }, icon: Icons.payment),
    QuickActionCard(title: "Services", mediaUrl: '', onTap: () {  }, icon: Icons.miscellaneous_services),
    QuickActionCard(title: "Absent", mediaUrl: '', onTap: () {  }, icon: Icons.accessibility),
  ];

  @override
  void onInit() {
    String? email = preferences.getString('email');
    fetchUserByEmail(email!);
    fetchAllAttendance();
    super.onInit();
  }

  List<AttendanceDataModel> attendanceList = [];
  RxBool isAttendanceLoading = true.obs;
  RxMap<String, int> statusCounts = {'absent': 0, 'late': 0, 'leave': 0}.obs;


  Future<void> fetchAllAttendance() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<AttendanceDataModel> fetchedAttendance = snapshot.docs
            .map((doc) => AttendanceDataModel.fromMap(doc.data()))
            .toList();
        attendanceList.assignAll(fetchedAttendance);
        for (var record in attendanceList) {
          String? status = record.status;
          if (statusCounts.containsKey(status)) {
            statusCounts[status] = (statusCounts[status] ?? 0) + 1;
          }
        }
        isAttendanceLoading.value = false;
      } else {
        attendanceList.clear();
        isAttendanceLoading.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching attendance data: $e');
      }
      isAttendanceLoading.value = false;
      attendanceList.clear();
    }
  }



  var selectedPage = 0.obs;
  void changePage(int value) {
    selectedPage.value = value;
  }

  Future<UserModel?> fetchUserByEmail(String email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('register')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromMap(snapshot.docs.first.data());
    }
    return null; // Return null if no user is found
  }

  RxString checkOutTime = "9:00 AM".obs;
}