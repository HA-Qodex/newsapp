import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/modules/providers/auth_provider.dart';

import '../../../resources/app_colors.dart';
import '../../../widgets/app_text_field.dart';

final loginState = StateProvider<bool>((ref) => true);

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Text(
                    ref.watch(loginState) ? "Login" : "Sign Up",
                    style: GoogleFonts.roboto(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  );
              }
            ),
             Consumer(
               builder: (BuildContext context, WidgetRef ref, Widget? child) {
                 return Text(
                   ref.watch(loginState)
                        ? "Please sign in to continue."
                        : "Register a new account.",
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.black45),
                  );
               }
             ),
            const SizedBox(
              height: 50,
            ),
            AppTextField(
              padding: EdgeInsets.zero,
              controller: emailController,
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
              controller: passwordController,
              label: 'Password',
              hint: 'Enter your password',
              iconData: Icons.lock,
              inputType: TextInputType.text,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Visibility(
                    visible: !ref.watch(loginState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                          padding: EdgeInsets.zero,
                          controller: passwordConfirmController,
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
              }
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
                  alignment: Alignment.centerRight,
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final isLoading = ref.watch(authProvider(context));
                      return IntrinsicWidth(
                        child: ElevatedButton(
                            onPressed: () {
                              ref.read(authProvider(context).notifier).login(email: emailController.text, password: passwordController.text);
                            },
                            child: isLoading
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
                                Text(ref.watch(loginState)
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
                      );
                    }
                  )),

            const SizedBox(
              height: 25,
            ),
             Align(
                alignment: Alignment.center,
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return RichText(
                      text: TextSpan(
                          text: ref.watch(loginState)
                              ? "Don't have an account?"
                              : "Already have an account?",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => ref.read(loginState.notifier).state = !ref.read(loginState.notifier).state,
                                text: ref.watch(loginState)
                                    ? " Sign Up"
                                    : " Login In",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          ]),
                    );
                  }
                ),
              )
          ],
        ),
      ),
    );
  }
}