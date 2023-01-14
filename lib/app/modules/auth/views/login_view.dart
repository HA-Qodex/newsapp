import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/app/modules/auth/controllers/auth_controller.dart';

import '../../../../widgets/app_textfield.dart';
import '../../../resources/app_colors.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Text(
                controller.loginPage.value ? "Login" : "Sign Up",
                style: GoogleFonts.roboto(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              );
            }),
            Obx(() {
              return Text(
                controller.loginPage.value
                    ? "Please sign in to continue."
                    : "Register a new account.",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black45),
              );
            }),
            const SizedBox(
              height: 50,
            ),
            AppTextField(
              padding: EdgeInsets.zero,
              controller: controller.emailController.value,
              label: 'Email',
              hint: 'Enter your email',
              iconData: Icons.email_outlined,
              inputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              padding: EdgeInsets.zero,
              controller: controller.passwordController.value,
              label: 'Password',
              hint: 'Enter your password',
              iconData: Icons.lock,
              inputType: TextInputType.text,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            Obx(() {
              return Visibility(
                visible: !controller.loginPage.value,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      padding: EdgeInsets.zero,
                      controller: controller.passConfController.value,
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                      iconData: Icons.lock,
                      inputType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              return Align(
                  alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
                    child: ElevatedButton(
                        onPressed: () {
                          !controller.isLoading.value ? controller.userLogin(context: context) : null;
                        },
                        child: controller.isLoading.value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'wait...',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.loginPage.value
                                      ? 'Login'
                                      : 'SignUp'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_right_alt_outlined,
                                    size: 25,
                                  )
                                ],
                              )),
                  ));
            }),
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              return Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: controller.loginPage.value
                          ? "Don\'t have an account?"
                          : "Already have an account?",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.loginPage.value =
                                  !controller.loginPage.value,
                            text: controller.loginPage.value
                                ? " Sign Up"
                                : " Login In",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ]),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
