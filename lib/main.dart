import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:neways_task/route/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/font_const.dart';
import 'feature/home/presentation/home_view.dart';
import 'firebase_options.dart';


final navigatorKey = GlobalKey<NavigatorState>();


late SharedPreferences preferences;
int? isInitScreen;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: firebaseOptions);
    log('Firebase initialized');
  }
  preferences = await SharedPreferences.getInstance();
  isInitScreen = preferences.getInt('initScreen');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neway',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white), // Modify or remove this if needed
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Set your preferred background color here
      ),
      debugShowCheckedModeBanner: true,
      home: const HomeView(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: FlutterSmartDialog.init(
        toastBuilder: (String msg) => Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade300
            ),
            child: Text(msg,
              style:   TextStyle(
                color: Colors.white,
                fontSize: TextSize.font16(context),
              ),
            ),
          ),
        ),
        loadingBuilder: (String msg) => CircularProgressIndicator()
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      navigatorKey: navigatorKey,
    );
  }
}

