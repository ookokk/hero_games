import 'package:flutter/material.dart';
import 'package:hero_games_case/view/auth/login/login_view.dart';
import 'package:hero_games_case/view/auth/register/register_view.dart';
import 'package:hero_games_case/view/home/home_view.dart';
import 'package:hero_games_case/view/splash/splash_view.dart';

class Routes {
  //Splash
  static const String splash = '/splash';
  //Auth
  static const String login = '/login';
  static const String register = '/register';
  //HOME
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashView(),
    login: (context) => LoginView(),
    register: (context) => RegisterView(),
    home: (context) => const HomeView(),
  };
}
