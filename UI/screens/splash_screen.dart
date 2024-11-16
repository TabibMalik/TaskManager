import 'dart:async'; // instead of 'dart:js'

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/UI/controllers/auth.dart';
import 'package:untitled/UI/screens/sign_in_screen.dart';
import 'package:untitled/UI/utils/assets_path.dart';
import '../widgets/Screen_background.dart';
import 'main_bottom_nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if(AuthController.isloggedin()){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const mainBottomNavBarScreen()));
    }else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsPath.logo,
                width: 120,)
            ],
          ),
        ),
      ),
    );
  }
}