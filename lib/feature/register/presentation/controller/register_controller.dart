
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neways_task/feature/home/presentation/home_view.dart';
import 'package:neways_task/main.dart';
import 'package:permission_handler/permission_handler.dart';
class RegisterController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    PermissionStatus status;
    if (Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33) {
      status = await Permission.photos.request();
    }
    else {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    }
    else {
      Get.snackbar("Permission Denied", "Gallery access is required to pick an image.");
    }
  }



  RxBool saveButtonEnableFlag =false.obs;

  void saveButtonEnable(){
    if( emailController.text.isNotEmpty
        && nameController.text.isNotEmpty
        && passwordController.text.isNotEmpty
    ){
      saveButtonEnableFlag.value = true;
    }
    else{
      saveButtonEnableFlag.value = false;
    }
  }

  Future<bool> signUpUser(String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      addUserDetails(
        nameController.text.trim(),
        genderController.text.trim(),
        dobController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        positionController.text.trim(),
        convertImageToBase64()
      );
      SmartDialog.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration Successful')));
      preferences.setInt('initScreen', 1);
      preferences.setString('email', emailController.text);
      Get.offAll(const HomeView());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email Provided already Exists')));
      }
      SmartDialog.dismiss();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      SmartDialog.dismiss();
    }
    return false;
  }

  Future addUserDetails(String name,String gender,String dob,String email,String password,String position,String image) async{
    await FirebaseFirestore.instance.collection('register').add({
      'name':name,
      'gender':gender,
      'dob':dob,
      'email':email,
      'password':password,
      'position':position,
      'image':image
    });
  }

  String convertImageToBase64() {
    if (selectedImage.value != null) {
      File imageFile = selectedImage.value!;
      List<int> imageBytes = imageFile.readAsBytesSync();
      return base64Encode(imageBytes);
    }
    return "";
  }


}