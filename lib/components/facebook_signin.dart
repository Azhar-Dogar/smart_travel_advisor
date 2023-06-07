// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:smart_travel_advisor/Pages/home_page.dart';
// import 'package:smart_travel_advisor/models/user_model.dart';
//
// Future<UserCredential?> signInWithFacebook(context) async {
//   final fb = FacebookLogin();
//   // Trigger the sign-in flow
//   final loginResult = await fb.logIn(permissions: [
//     FacebookPermission.publicProfile,
//     FacebookPermission.email,
//   ]);
//   print(loginResult.status.toString());
//   if (loginResult.status == FacebookLoginStatus.success) {
//     print("success");
//     final email = await fb.getUserEmail() ?? "";
//
//     final image = await fb.getProfileImageUrl(width: 100);
//     final profile = await fb.getUserProfile();
//     final FacebookAccessToken accessToken = loginResult.accessToken!;
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(accessToken.token);
//
//     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     print(FirebaseAuth.instance.currentUser!.uid);
//     print(FirebaseAuth.instance.currentUser!.uid);
//     print(FirebaseAuth.instance.currentUser!.uid);
//     print("facebook login");
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set(UserModel(
//                 email: email,
//                 uid: FirebaseAuth.instance.currentUser!.uid,
//                 profilePic: image!,
//                 userName: profile!.name!,
//                 dob: DateTime.now().millisecondsSinceEpoch)
//             .toMap());
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//   }
//   // Create a credential from the access token
// }
