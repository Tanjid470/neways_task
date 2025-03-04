import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:neways_task/config/font_const.dart';
import 'package:neways_task/const/app_colors.dart';
import 'package:neways_task/feature/register/presentation/register_view.dart';
import 'controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: Get.height / 4,
            //   width: Get.width,
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(AppImages.nubccLogoRemovebg),
            //       )
            //   ),
            // ),
            inputHeader(context, "Email"),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: loginController.emailController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  )),
              child: TextField(
                controller: loginController.emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'HindSiliguri',
                    // color: HexColor('#7A7A7A'),
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Enter your email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: loginController.emailController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'HindSiliguri',
                      color: Colors.grey.shade400,
                      fontSize: 16),
                  //hintStyle: const TextStyle(color: Colors.orangeAccent),
                ),
                onChanged: (value) {
                  loginController.saveButtonEnable();
                  setState(() {});
                },
              ),
            ),
            inputHeader(context, "Password"),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: loginController.passwordController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  )),
              child: TextField(
                controller: loginController.passwordController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'HindSiliguri',
                    // color: HexColor('#7A7A7A'),
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Enter your password",
                  prefixIcon: Icon(
                    Icons.password,
                    color: loginController.passwordController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColor.baseColor,
                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'HindSiliguri',
                      color: Colors.grey.shade400,
                      fontSize: 16),
                  //hintStyle: const TextStyle(color: Colors.orangeAccent),
                ),
                onChanged: (value) {
                  loginController.saveButtonEnable();
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            actionButton(context),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don\'t have an account?",
                  style: TextStyle(
                      fontSize: TextSize.font16(context),
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterView()),
                    );
                  },
                  child: Text(
                    " Register",
                    style: TextStyle(
                        fontSize: TextSize.font18(context),
                        fontWeight: FontWeight.w700,
                        color: AppColor.baseColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding inputHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TextSize.font15(context),
          fontWeight: FontWeight.w600,
          color: const Color(0xff5E6579),
        ),
      ),
    );
  }

  Widget actionButton(BuildContext contextPass) {
    return Obx(
          () {
        return loginController.saveButtonEnableFlag.value
            ? InkWell(
            onTap: () async{
              bool checkValidEmail = loginController.userEmailInputValidation(loginController.emailController.text);
              if(checkValidEmail){
                SmartDialog.showLoading();
                 await loginController.signInUser(loginController.emailController.text, loginController.passwordController.text, contextPass);
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(colors: [
                      AppColor.baseColor,
                      AppColor.baseColorShadow
                    ]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, offset: Offset(1.5, 1.5))
                    ]),
                height: 50,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'HindSiliguri',
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: TextSize.font20(context)),
                    textAlign: TextAlign.center,
                  ),
                )))
            : InkWell(
          onTap: () => loginController.userEmailInputValidation(loginController.emailController.text),
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey.shade500,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
                  ]),
              height: 50,
              width: double.maxFinite,
              child: Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'HindSiliguri',
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.font20(context)),
                  textAlign: TextAlign.center,
                ),
              )),
        );
      },
    );
  }
}