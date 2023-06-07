import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';
import 'package:smart_travel_advisor/Pages/questions_screen.dart';
import 'package:smart_travel_advisor/components/facebook_signin.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

import '../components/google_signin.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, }) : super(key: key);
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  get screenHeight => MediaQuery.of(context).size.width;

  get screenWidth => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body:  SingleChildScrollView( 
        child: Consumer<ProviderClass>(
          builder: (BuildContext context, value, Widget? child)=>
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoImage(),

             Text(
               "Smart Travel Advisor",
               style: AppTextStyles.popins(
                   style: const TextStyle(
                     fontSize: 14,
                     letterSpacing: 2,
                     wordSpacing: 5.0,
                   )),
             ),
                SizedBox(height: screenHeight * 0.3),
              Align (
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Continue with",
                  style: AppTextStyles.popins(style: TextStyle(fontSize: 14,
                  color: Colors.grey.shade600
                  )),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Align (
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginButtons("assets/appLogo/fb_logo.png", "Facebook",
                        Colors.white, const Color(0xFF3B5998),
                        onPressed: () async {
                          await  value.signInWithFacebook(context);

                        }),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    loginButtons("assets/appLogo/logo_google.png", "Google",
                        Colors.grey, Colors.grey.shade100, onPressed: () async {
                      bool result = await value.signInWithGoogle(context);
                      //widget.provider.getUserData();
                      if (result) {


                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionsScreen()), (route) => false, );
                      }
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // image logo icon
  Widget logoImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Center(
        child: Container(
          height: screenHeight * 0.4,
          width: screenWidth * 0.4,
          decoration: const BoxDecoration(

              image: DecorationImage(
                  image: AssetImage("assets/appLogo/app_icon.png"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Widget loginButtons(image, String text, Color textColor, Color buttonColor,
      {required void Function()? onPressed}) {
    return Container(
      width: 130,
      height: 36,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor)),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image(image: AssetImage(image)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  text,
                  style: AppTextStyles.popins(
                      style: TextStyle(fontSize: 13, color: textColor)),
                ),
              ),
            ],
          )),
    );
  }


// final fb = FacebookLogin();
//   fbLogin(BuildContext context) async {
//       await fb.logOut();
    
//     try {
//       final res = await fb.logIn(permissions: [
//         FacebookPermission.publicProfile,
//         FacebookPermission.email,
//       ]);
     
//       debugPrint("error : ${res.error.toString()}");
//       debugPrint("here : ${res.status.toString()}");
//       if (res.status == FacebookLoginStatus.success) {
//         final email = await fb.getUserEmail() ?? "";
//         final profile = await fb.getUserProfile();

//         print("object");
//         print("object");
//         print("object");
//         print("object");
//         print("object");
//         print("object");
//         print("id: ${FirebaseAuth.instance.currentUser!.uid}");
//            await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
//             "email": email,
//             "userName": profile!.name ?? "",
          
            
//     });
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>DemoScreen()  ), (route) => false);
      
//       }
//       else{
//        // Navigator.of(context).pop();
//        print("cancel");
//        print("cancel");
//        print("cancel");print("cancel");
//        print("cancel");
//        print("cancel");

       
//       }
//     } catch (e) {
    
  
   
//     }
//   }

 
}
