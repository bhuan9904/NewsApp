// import 'package:easy_splash_screen/easy_splash_screen.dart';
// import '../home.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:way2_news_app_design/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/heeltechround.png',),
      title: Text(
        "DAILY BHARAT",
        style: TextStyle(
          fontSize: 25,
          // fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: HomeScreen(),
      durationInSeconds: 7,
    );
  }
}