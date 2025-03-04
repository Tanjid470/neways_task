import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:neways_task/feature/home/presentation/home_view.dart';
import 'package:neways_task/main.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool saveButtonEnableFlag =false.obs;

  void saveButtonEnable(){
    if(emailController.text.isNotEmpty){
      saveButtonEnableFlag.value = true;
    }
    if(passwordController.text.isNotEmpty){
      saveButtonEnableFlag.value = true;
    }
    else{
      saveButtonEnableFlag.value = false;
    }
  }

  bool userEmailInputValidation(String email){
    bool emailValid = RegExp(
        r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
    ).hasMatch(email);

    if(email.isEmpty){
      SmartDialog.showToast('Enter your email');
    }
    else if(emailValid != true){
      SmartDialog.showToast('This is not a valid email');
    }
    else{
      //SmartDialog.showToast('Enter valid email');
    }
    return emailValid;
  }

  Future<void> signInUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      SmartDialog.dismiss();
      preferences.setInt('initScreen', 1);
      Get.offAll(const HomeView());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are Logged in')));
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user Found with this Email')));
      } else if (exception.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password did not match')));
      } else if (exception.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user Found with this Email & Password')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${exception.message}")));
      }
      SmartDialog.dismiss();
    }
  }
}