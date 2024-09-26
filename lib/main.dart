import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:binarytranslate/pages/home.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EasySplashScreen(logo: Image.asset("logo.jpg"),
          title: Text('مترجم صوتی باینری',style: TextStyle(fontFamily: 'irani',),),
          showLoader: true,
          loaderColor: Colors.blue,
          loadingText: Text(' ...درحال بارگیری اطلاعات\n      version 1.1.2',style: TextStyle(fontFamily: "irani"),),
          durationInSeconds: 3,
          navigator:homepage(),
        ),
      ),
    );
  }
}