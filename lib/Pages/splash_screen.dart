import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';
import 'package:smart_travel_advisor/Pages/questions_screen.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';

import '../services/utils/app_colors.dart';
import 'login_screen.dart';

class MySplashscreen extends StatefulWidget {
  const MySplashscreen({Key? key}) : super(key: key);

  @override
  State<MySplashscreen> createState() => _MySplashscreenState();
}

class _MySplashscreenState extends State<MySplashscreen> {
  splashServices() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 4),
        () async => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const QuestionsScreen()),
            (route) => false),
      );
    } else {
      Timer(
        const Duration(seconds: 4),
        () async => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(create:(context)=>ProviderClass() ,
                  child: Consumer<ProviderClass>(
                      builder: (BuildContext context, value, Widget? child) =>
                           LoginScreen()),
                )),
            (route) => false),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    splashServices();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          height: screenHeight * 0.5,
          width: screenWidth * 0.7,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appLogo/app_icon.png"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
