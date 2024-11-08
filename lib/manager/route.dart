import 'package:flutter/material.dart';
import 'package:note_app/features/add_category/screens/add_new_category_screen.dart';
import 'package:note_app/features/auth/screens/login_screen.dart';
import 'package:note_app/features/auth/screens/sign_up_screen.dart';
import 'package:note_app/features/home/screens/home_screen.dart';
import 'package:note_app/features/splash/screens/splash_screen.dart';


class RouteManager {
  static String splashScreen = '/';
  static String loginScreen = '/LoginScreen';
  static String signUpScreen = '/SignUpScreen';
  static String homeScreen = '/HomeScreen';
  static String addNewCategoryScreen = '/AddNewCategoryScreen';

  static Map<String, Widget Function(BuildContext)> route() {
    return {
      splashScreen: (context) => const SplashScreen(),
      loginScreen: (context) => const LoginScreen(),
      signUpScreen: (context) => const SignUpScreen(),
      homeScreen: (context) => const HomeScreen(),
      addNewCategoryScreen: (context) => const AddNewCategoryScreen(),
    };
  }
}
