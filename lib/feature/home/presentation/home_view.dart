import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/config/responsive_scale.dart';
import 'package:neways_task/const/app_colors.dart';
import 'package:neways_task/feature/home/data/attendance_data_model.dart';
import 'package:neways_task/feature/home/data/user_info_model.dart';
import 'package:neways_task/feature/home/presentation/widget/leave_status_card.dart';
import 'package:neways_task/feature/home/presentation/widget/quick_action_card.dart';
import 'package:neways_task/feature/home/presentation/widget/widget_background_color.dart';
import 'package:neways_task/feature/login/presentation/login_view.dart';
import 'package:neways_task/feature/user_profile_info/presentation/user_info_view.dart';
import 'package:neways_task/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'controller/home_controller.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              userAppBar(),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalGap(context, 15),
                          quickAction(),
                          verticalGap(context, 3),
                          totalLeave(),
                          verticalGap(context, 3),
                          newFeatureSlider(),
                          verticalGap(context, 3),
                          attendanceCalendar(),
                          verticalGap(context, 3),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          inOutTrackCard()
        ],
      ),
    );
  }

  Widget totalLeave() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.baseColorShadow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.summarize_outlined,
                            color: AppColor.blackColor,
                            size: TextSize.font20(context),
                          ),
                          horizontalGap(context, 1),
                          Text('Total leave',
                              style: TextStyle(
                                  fontSize: TextSize.font14(context),
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      verticalGap(context, 1),
                      CircleAvatar(
                          radius: 32,
                          backgroundColor: AppColor.baseColor,
                          child: Text(
                            '10',
                            style: TextStyle(
                                fontSize: TextSize.font28(context),
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          ))
                    ]),
              )),
          horizontalGap(context, 2),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LeaveStatusCard(
                      icon: Icons.pending_actions, title: 'Pending', days: '3'),
                  LeaveStatusCard(
                      icon: Icons.offline_pin_outlined,
                      title: 'Approved',
                      days: '5'),
                  LeaveStatusCard(
                      icon: Icons.cancel, title: 'Rejected', days: '2'),
                ],
              ))
        ],
      ),
    );
  }

  Widget userAppBar() {
    return Container(
      height: ResponsiveScale.of(context).hp(24),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: AppColor.baseColor,
      ),
      child: Column(
        children: [
          SizedBox(height: ResponsiveScale.of(context).hp(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      String? email = preferences.getString('email');
                      Get.to(UserInfoView(email: email ?? 'test@gmail.com'));
                    },
                    child: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.white, width: 1.5),
                      ),
                      child: FutureBuilder<UserModel?>(
                        future: homeController.fetchUserByEmail(
                            preferences.getString('email') ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                                color: Colors.white); // Placeholder
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return ClipOval(
                              child: Image.network(
                                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3',
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          UserModel user = snapshot.data!;

                          String base64Image = user.image;
                          if (base64Image.isNotEmpty) {
                            Uint8List bytes = base64Decode(base64Image);
                            return ClipOval(
                              child: Image.memory(
                                bytes,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return ClipOval(
                              child: Image.network(
                                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3',
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FutureBuilder<UserModel?>(
                    future: homeController
                        .fetchUserByEmail(preferences.getString('email') ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(color: Colors.white);
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text("User not found",
                            style: TextStyle(color: Colors.white));
                      }
                      UserModel user = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.name, // Display fetched name
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(user.position, // Display fetched position
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      preferences.setInt('initScreen', 0);
                      Get.offAll(const LoginView());
                    },
                    child: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget quickAction() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quick Actions',
                style: TextStyle(
                    fontSize: TextSize.font18(context),
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold)),
            Text('View All',
                style: TextStyle(
                    fontSize: TextSize.font12(context),
                    color: AppColor.blueGrey,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(
          height: ResponsiveScale.of(context).hp(12),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeController.quickActionCardList.length,
            itemBuilder: (BuildContext context, int index) {
              return QuickActionCard(
                title: homeController.quickActionCardList[index].title,
                mediaUrl: '',
                onTap: () {},
                icon: homeController.quickActionCardList[index].icon,
              );
            },
          ),
        )
      ],
    );
  }

  Widget inOutTrackCard() {
    return Positioned(
        top: ResponsiveScale.of(context).hp(18),
        left: 15,
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    spacing: ResponsiveScale.of(context).hp(1),
                    children: [
                      Row(
                        spacing: ResponsiveScale.of(context).wp(2),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetBackgroundColor(
                              child: Icon(
                            Icons.calendar_month_outlined,
                            size: TextSize.font18(context),
                          )),
                          Text('11 wed | 2025',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold)),
                          WidgetBackgroundColor(
                            child: Text(
                              'Shift Morning',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('9:00 AM',
                              style: TextStyle(
                                  fontSize: TextSize.font16(context),
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold)),
                          Text('Check In',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  color: AppColor.greyColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('01:29:45',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          Text('Time Remaining',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: AppColor.greyColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Text(homeController.checkOutTime.value,
                                style: TextStyle(
                                    fontSize: TextSize.font12(context),
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold));
                          }),
                          Text('Check Out',
                              style: TextStyle(
                                  fontSize: TextSize.font12(context),
                                  color: AppColor.greyColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        DateTime now = DateTime.now();
                        String period = now.hour >= 12 ? "PM" : "AM";
                        homeController.checkOutTime.value =
                            "${now.hour}:${now.minute} $period";
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColor.greyColor,
                        child: Icon(
                          Icons.fingerprint,
                          size: TextSize.font30(context),
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    Text(
                      'Check Out',
                      style: TextStyle(
                          fontSize: TextSize.font14(context),
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget newFeatureSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          SizedBox(
            height: ResponsiveScale.of(context).hp(15),
            child: CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/splash.png'),
                        fit: BoxFit.cover),
                    border: Border.all(color: AppColor.baseColor),
                  ),
                );
              },
              options: CarouselOptions(
                height: MediaQuery.of(context)
                    .size
                    .height, // Adjust height accordingly
                autoPlay: true, // Enable auto-play
                autoPlayInterval:
                    const Duration(seconds: 3), // Time between transitions
                enlargeCenterPage: true, // Enlarge the current item
                viewportFraction: 1.0, // Display one item at a time
                onPageChanged: (index, reason) {
                  homeController.changePage(index);
                },
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return InkWell(
                    onTap: () => homeController.changePage(index),
                    child: Container(
                      width: homeController.selectedPage.value == index
                          ? 15.0
                          : 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        color: homeController.selectedPage.value == index
                            ? AppColor.baseColor
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget attendanceCalendar(){
    return  Obx(() {
      if (homeController.isAttendanceLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return Container(
        color: Colors.white,
        child: TableCalendar(
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2100, 12, 31),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return homeController.attendanceList
                .any((attendance) {
              DateTime attendanceDate =
              DateFormat('dd/MM/yyyy')
                  .parse(attendance.date);
              return attendanceDate.day == day.day &&
                  attendanceDate.month == day.month &&
                  attendanceDate.year == day.year;
            });
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              final matchingAttendance = homeController.attendanceList.firstWhere((attendance) {
                DateTime attendanceDate = DateFormat('dd/MM/yyyy').parse(attendance.date);
                return attendanceDate.day == day.day &&
                    attendanceDate.month == day.month &&
                    attendanceDate.year == day.year;
              },
                orElse: () => AttendanceDataModel(color: 'red', date: '', status: ''), // Provide a default
              );

              Color markerColor;
              try {
                markerColor = Color(int.parse('0xFF${matchingAttendance.color.replaceAll('#', '')}')).withOpacity(.25);
              } catch (e) {
                markerColor = Colors.transparent;
              }

              return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: markerColor,
                    shape: BoxShape.rectangle,
                  ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          matchingAttendance.status,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: TextSize.font10(context),
                          )
                      )
                  )
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: TextSize.font20(context),// Always black
                      fontWeight: FontWeight.bold, // Always bold
                    ),
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              return Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: Colors.black, // Always black
                    fontWeight: FontWeight.bold, // Always bold
                  ),
                ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: Colors.black, // Always black
                    fontWeight: FontWeight.bold, // Always bold
                  ),
                ),
              );
            },
          ),
          weekendDays: [DateTime.friday],
          headerVisible: true,
          daysOfWeekVisible: true,
          pageJumpingEnabled: false,
          pageAnimationEnabled: true,
          sixWeekMonthsEnforced: false,
          shouldFillViewport: false,
          weekNumbersVisible: false,

          onDaySelected: (selectedDay, focusedDay) {
            print('Selected Day: ${selectedDay.toIso8601String()}');
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.red, // Default marker decoration
              shape: BoxShape.circle,
            ),
            holidayDecoration: BoxDecoration(
              color: Colors.red, // Default marker decoration
              shape: BoxShape.circle,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.red),
          ),

        ),
      );
    });
  }
}
