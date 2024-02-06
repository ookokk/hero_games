// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero_games_case/const/device_size.dart';
import 'package:hero_games_case/service/auth_manager.dart';
import 'package:hero_games_case/widget/auth_button.dart';
import 'package:hero_games_case/widget/custom_alert.dart';
import 'package:hero_games_case/widget/custom_text_field.dart';
import 'package:hero_games_case/widget/register_btn.dart';

class LoginView extends StatelessWidget {
  LoginView({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    'assets/get_started1.svg',
                    height: 170,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      icon: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  PasswordControllerTextField(
                    passwordController: passwordController,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  buildAuthButton(authManager, context),
                  TextButton(
                    onPressed: () async {},
                    child: Text(
                      'osman',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
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
                    text: 'Create an Account',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register');
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

  AuthButton buildAuthButton(AuthManager authManager, BuildContext context) {
    return AuthButton(
      text: 'Login',
      onTap: () async {
        try {
          User? user = await authManager.login(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
          if (user == null) {
            CustomAlert().showAuthAlertDialog(
                true, context, 'Error', 'User not found', 'Okay', () {
              Navigator.pop(context);
            });
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        } catch (e) {
          CustomAlert().showAuthAlertDialog(
              true, context, 'Error', e.toString(), 'Okay', () {});
        }
      },
    );
  }
}

class PasswordControllerTextField extends StatelessWidget {
  const PasswordControllerTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: passwordController,
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
