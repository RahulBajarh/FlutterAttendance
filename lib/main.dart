import 'package:flutter/material.dart';
import 'package:contata_attendance/pages/splash_screen.dart';
import 'package:contata_attendance/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Contata Attendance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffef4c25)),
          useMaterial3: true,
          //fontFamily: GoogleFonts.lato().fontFamily,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        ),
        routes: {
          "/": (context) => const SplashScreen(),
          MyRoutes.homeRoute: (context) => const MyHomePage(),
          MyRoutes.loginRoute: (context) => const LoginPage(),
        },
      ),
    );
  }
}
