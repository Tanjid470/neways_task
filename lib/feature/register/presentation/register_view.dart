import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/config/responsive_scale.dart';
import 'package:neways_task/const/app_colors.dart';
import 'package:neways_task/global_widget/custom_text_field.dart';
import 'controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: ResponsiveScale.of(context).hp(5)),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                  fontSize: TextSize.font24(context),
                                  fontFamily: 'HindSiliguri',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Neway',
                              style: TextStyle(
                                  fontSize: TextSize.font24(context),
                                  color: AppColor.baseColor,
                                  fontFamily: 'HindSiliguri',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('Register',
                            style: TextStyle(
                                fontSize: TextSize.font24(context),
                                fontFamily: 'HindSiliguri')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalGap(context, 2),
            allDataInputField(),
          ],
        ),
      ),
      floatingActionButton: SafeArea(child: saveButton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget allDataInputField() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalGap(context, 2),
          Obx(() => GestureDetector(
            onTap: registerController.pickImage,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppColor.baseColorShadow,
              backgroundImage: registerController.selectedImage.value != null
                  ? FileImage(registerController.selectedImage.value!)
                  : null,
              child: registerController.selectedImage.value == null
                  ? Icon(Icons.add_a_photo_outlined, color: Colors.black, size: 30)
                  : null,
            ),
          )),
          verticalGap(context, 2),
          CustomTextField(
            controller: registerController.nameController,
            hintText: 'Enter your name',
            icon: Icons.person,
            fieldName: 'Name',
            isRequired: true,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
          CustomTextField(
            controller: registerController.dobController,
            hintText: 'Date of birth',
            icon: Icons.date_range,
            fieldName: 'Date',
            isRequired: false,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
          CustomTextField(
            controller: registerController.genderController,
            hintText: 'gender',
            icon: Icons.accessibility,
            fieldName: 'Gender',
            isRequired: false,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
          CustomTextField(
            controller: registerController.positionController,
            hintText: 'position',
            icon: Icons.motion_photos_auto_sharp,
            fieldName: 'Position',
            isRequired: true,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
          CustomTextField(
            controller: registerController.emailController,
            hintText: 'Enter your email',
            icon: Icons.email_outlined,
            fieldName: 'Email',
            isRequired: true,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
          CustomTextField(
            controller: registerController.passwordController,
            hintText: 'password',
            icon: Icons.code,
            fieldName: 'Password',
            isRequired: true,
            saveButtonEnable: registerController.saveButtonEnable,
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return registerController.saveButtonEnableFlag.value
        ? InkWell(
            onTap: () async {
              SmartDialog.showLoading();
              registerController.signUpUser(
                  registerController.emailController.text,
                  registerController.passwordController.text,
                  'name',
                  context
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color(0xff0346ae),
                    Color(0xff012351),
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black, // Shadow color
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    )
                  ]),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                    fontSize: TextSize.font18(context),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : InkWell(
            onTap: () => SmartDialog.showToast('fill up all required field'),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black, // Shadow color
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    ),
                  ]),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HindSiliguri',
                    fontSize: TextSize.font18(context),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
