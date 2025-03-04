import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'feature/home/presentation/home_view.dart';
int? isInitScreen;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseOptions options = await firebaseInit();
  //await Firebase.initializeApp(options: options);
  runApp(const MyApp());
}

Future<FirebaseOptions> firebaseInit() async{
  String googleServicesJsonString = await rootBundle.loadString('android\\app\\google-services.json');
  final googleServicesJson = jsonDecode(googleServicesJsonString);
  final projectId = googleServicesJson['project_info']["project_id"];

  final messagingSenderId = googleServicesJson['project_info']["project_number"];
  final storageBucket = googleServicesJson['project_info']["storage_bucket"];
  final appId = googleServicesJson['client'][0]["client_info"]["mobilesdk_app_id"];
  final apiKey = googleServicesJson['client'][0]["api_key"][0]["current_key"];

  FirebaseOptions options = FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  );

  return options;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

