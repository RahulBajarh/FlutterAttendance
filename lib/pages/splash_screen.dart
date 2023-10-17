import 'dart:async';

import 'package:flutter/material.dart';
import 'package:contata_attendance/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const keylogin = "isLogin";

  @override
  void initState() {
    super.initState();
    // Call your async function when the page loads

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(child: Image.asset("assets/images/contata.png")),
      ),
    );
  }

  void whereToGo() async {
    // Retrieve user data
    final prefs = await SharedPreferences.getInstance();
    final isLoggedin = prefs.getBool(keylogin) ?? false;

    Timer(
      const Duration(seconds: 2),
      () {
        if (isLoggedin) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      },
    );
  }
}
