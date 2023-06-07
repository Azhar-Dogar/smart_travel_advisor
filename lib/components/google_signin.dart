// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../Pages/home_page.dart';
// import '../models/user_model.dart';
//
//
// class Authentications{
//
// Future<bool> signInWithGoogle(BuildContext context,) async {
//   bool result = false;
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication? googleAuth =
//     await googleUser?.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//
//     UserCredential userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     print("google login");
//     print(FirebaseAuth.instance.currentUser?.uid);
//     print(FirebaseAuth.instance.currentUser?.uid);
//     print(FirebaseAuth.instance.currentUser?.uid);
//     print(FirebaseAuth.instance.currentUser?.uid);
//     User? user = userCredential.user;
//     if (user != null) {
//       if (userCredential.additionalUserInfo!.isNewUser) {
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .set(UserModel(
//             email: user.email!,
//             uid: user.uid,
//             profilePic: user.photoURL!,
//             dob: DateTime.now().millisecondsSinceEpoch,
//             userName: user.displayName!)
//             .toMap());
//       }
//
//       result = true;
//     }
//     return result;
//   } catch (e) {
//     print(e);
//   }
//
//   return result;
// }
// }