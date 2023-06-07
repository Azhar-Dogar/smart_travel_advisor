import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/create_trip_screen.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';
import 'package:smart_travel_advisor/Pages/login_screen.dart';
import 'package:smart_travel_advisor/Pages/splash_screen.dart';
import 'package:smart_travel_advisor/practise.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ProviderClass())],
      child: MyApp(),
      

  ));
}

class MyApp extends StatelessWidget {
  
   MyApp({super.key});
    
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MySplashscreen (),
    );
  }
}
