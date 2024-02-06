// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero_games_case/const/device_size.dart';
import 'package:hero_games_case/service/auth_manager.dart';
import 'package:hero_games_case/widget/auth_button.dart';
import 'package:hero_games_case/widget/custom_alert.dart';
import 'package:hero_games_case/widget/custom_text_field.dart';
import 'package:hero_games_case/widget/register_btn.dart';

class RegisterView extends StatelessWidget {
  RegisterView({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailCnt = TextEditingController();
  final TextEditingController pwCnt = TextEditingController();
  final TextEditingController pwAgainCnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authManager = AuthManager();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/bg.svg',
              fit: BoxFit.cover,
              height: DeviceSize.kHeight(context),
              width: DeviceSize.kWidth(context),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/register.svg',
                    height: 150,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                      controller: emailCnt,
                      hintText: 'Email',
                      obscureText: false,
                      icon: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  PasswordTextField(pwCnt: pwCnt),
                  const SizedBox(
                    height: 18,
                  ),
                  PasswordAgainTextField(
                    pwAgainCnt: pwAgainCnt,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  buildAuthElevatedButton(context, authManager),
                  const SizedBox(
                    height: 18,
                  ),
                  const Divider(
                    height: 0.5,
                    thickness: 0.7,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  RegisterButton(
                    text: 'Log in your account',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AuthButton buildAuthElevatedButton(
      BuildContext context, AuthManager authManager) {
    return AuthButton(
      text: 'Register',
      onTap: () async {
        try {
          if (pwCnt.text != pwAgainCnt.text) {
            CustomAlert().showAuthAlertDialog(
                true, context, 'Error', 'Passwords do not match', "Okay", () {
              Navigator.pop(context);
            });
            return;
          }
          User? user = await authManager.register(
            emailCnt.text,
            pwCnt.text,
          );
          if (user != null) {
            Future.microtask(() => CustomAlert().showAuthAlertDialog(
                    true,
                    context,
                    'Success',
                    'User Created ${emailCnt.text.trim()} ',
                    "Get Started", () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                }));
          }
        } catch (e) {
          String errorMessage = e.toString().toLowerCase();
          if (errorMessage.contains("error") ||
              errorMessage.contains("email-already-in-use") ||
              errorMessage.contains("invalid")) {
            Future.microtask(() {
              CustomAlert().showAuthAlertDialog(
                  true, context, 'Error', 'An error occured.', 'Okay', () {
                Navigator.pop(context);
              });
            });
          } else {
            Future.microtask(() {
              CustomAlert().showAuthAlertDialog(
                  true, context, 'Error', 'An error occured.', "", () {});
            });
          }
        }
      },
    );
  }
}

class PasswordAgainTextField extends StatelessWidget {
  const PasswordAgainTextField({
    super.key,
    required this.pwAgainCnt,
  });

  final TextEditingController pwAgainCnt;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: pwAgainCnt,
      hintText: 'Confirm password',
      obscureText: true,
      icon: const Icon(
        Icons.lock,
        color: Colors.blue,
      ),
      onIconButtonPressed: () {},
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.pwCnt,
  });

  final TextEditingController pwCnt;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: pwCnt,
      hintText: 'Password',
      obscureText: true,
      icon: const Icon(
        Icons.lock,
        color: Colors.blue,
      ),
      onIconButtonPressed: () {},
    );
  }
}
