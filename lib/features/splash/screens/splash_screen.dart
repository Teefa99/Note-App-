import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/manager/images.dart';
import 'dart:async';

import 'package:note_app/manager/route.dart';
import 'package:note_app/manager/ui/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      // if (SharedPreferenceHelper.getData(key: AppConstants.userLat) != null) {
      //   if (SharedPreferenceHelper.loadUserData()?.userID == null) {
      //     Navigator.pushReplacementNamed(context, RouteManager.loginScreen);
      //   } else {
      //     Navigator.pushReplacementNamed(context, RouteManager.templateScreen);
      //   }
      // } else {
      //   Navigator.pushReplacementNamed(
      //       context, RouteManager.chooseLanguageScreen);
      // }
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, RouteManager.loginScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteManager.homeScreen);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UiColor.primaryColor,
        body: SafeArea(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    ImageManager.logo,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                  ),
                  const Spacer()
                ],
              ),
            )));
  }
}
