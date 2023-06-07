import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_travel_advisor/Pages/questions_screen.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';
import 'package:smart_travel_advisor/models/user_model.dart';
import '../Pages/home_page.dart';
import '../Pages/splash_screen.dart';
import '../functions/functions.dart';
import '../models/myTrips_model.dart';
import 'dart:io';

import '../widgets/loadingDialogue.dart';

class ProviderClass with ChangeNotifier {
  ProviderClass() {
    getPlaces();
    if (FirebaseAuth.instance.currentUser != null) {
      getUserData();
      getTrips();
    }

  }
  int? q1GroupValue;
  int? q2GroupValue ;
  int? q3GroupValue ;
  int? q4GroupValue ;
  int? q5GroupValue ;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  List<SearchedPlaces> places = [];
  List<SearchedPlaces> docList = [];
  List<SearchedPlaces> locations = [];
  List<SearchedPlaces> tripLocations = [];
  List<SearchedPlaces> totalLocations = [];
  List<MyTrips> trips = [];
  UserModel? user;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? userStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? tripsStream;
  final ImagePicker _picker = ImagePicker();
  Color categoryColor = Colors.green;
  Color second = Colors.white;
  updateProfile(String name, dynamic value) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({name: value});
    notifyListeners();
  }
  changeRadioValue(int? value,int? groupValue){
   groupValue = value;
   notifyListeners();
  }
 deleteCurrentLocation(int index){
    locations.removeAt(index);
    notifyListeners();
 }
 signOut(context)async{
   LoadingDialogue.showLoaderDialog(context);
  await GoogleSignIn().signOut();
   await FirebaseAuth.instance.signOut();
   notifyListeners();
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>  MySplashscreen() ), (route) => false);
 notifyListeners();
 }
  addTrip(String tripName, String category, List<SearchedPlaces> locations,
      context) async {
    showDialog(
        context: context,
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                AlertDialog(
                  content: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ));
    String uid = FirebaseAuth.instance.currentUser!.uid;
    List items = [];
    DocumentReference doc = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("trips")
        .doc();
    for (int i = 0; i < locations.length; i++) {
      items.add({
        "name": locations[i].name,
        "address": locations[i].address,
        "hours": locations[i].hours,
        "reviews": locations[i].reviews,
        "ratings": locations[i].ratings,
        "imageUrl": locations[i].imageUrl,
        "documentName": locations[i].documentName,
        "latitude": locations[i].latitude,
        "longitude": locations[i].longitude,
        "phoneNumber": locations[i].phoneNumber
      });
    }
    await doc.set({
      "tripName": tripName,
      "category": category,
      "tripId":doc.id,
      "locations": FieldValue.arrayUnion(items)
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Trip Addeed Sucessfully")));
    notifyListeners();
  }

  deleteTrip(String tripId,context) async {
    showDialog(
        context: context,
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                AlertDialog(
                  content: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ));
    await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("trips")
        .doc(tripId)
        .delete();
    notifyListeners();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Trip deleted Successfully")));
  }

  getTrips() {
    tripsStream = users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("trips")
        .snapshots()
        .listen((event) {
      trips = [];
      tripLocations = [];
      totalLocations = [];
      for (var element in event.docs) {
        trips.add(MyTrips.fromMaP(element.data()));
      }
      trips.forEach((element1) { 
        tripLocations = [];
        element1.locations.forEach((element) { 
         tripLocations.add(SearchedPlaces.fromMap(element));
         totalLocations.add(SearchedPlaces.fromMap(element));
         element1.tempList = tripLocations;
        });
      });
    });
    notifyListeners();
  }

  getUserData() {
    //String uid = FirebaseAuth.instance.currentUser!.uid;
      userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      user = UserModel.fromMap(event.data()!);
      notifyListeners();
    });
    notifyListeners();
  }

  clearLocations() {
    locations = [];
    notifyListeners();
  }
  getCurrentDoc(List<String> documentName) {
    docList = [];
    print(places.length);
    print("object");
    documentName.forEach((doc) {
      places.forEach((place) {
        if(place.documentName==doc){
          docList.add(place);
        }
      });
    });
    // for (var element in places) {
    //   if (element.documentName == documentName) {
    //     docList.add(element);
    //     print("this is doc:${docList.length}");
    //     print("this is$documentName");
    //   }
    // }
  }

  addLocation(SearchedPlaces place) {
    locations.add(place);
    notifyListeners();
  }
  addSelectedLocations(List<SearchedPlaces> list){
    locations = [];
    list.forEach((element) {
      locations.add(element);
      print(locations.length);
      print("this is location");
    });
  }
  deleteLocation(int index) {}

  getPlaces() {
    FirebaseFirestore.instance.collection("places").snapshots().listen((event) {
      places = [];
      for (var element in event.docs) {
        places.add(SearchedPlaces.fromMap(element.data()));
      }
      notifyListeners();
    });
    notifyListeners();
  }
  final _storage = FirebaseStorage.instance;
  Future getImage(BuildContext context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        File file = File(value.path);
        Functions.showLoaderDialog(context);
        uploadPic(file,context);
        //Navigator.pop(context);
      }
    });
  }

  uploadPic(File file,context) async {
    await _storage.ref().child(FirebaseAuth.instance.currentUser!.uid).putFile(file);
    var url = await _storage.ref().child(FirebaseAuth.instance.currentUser!.uid).getDownloadURL();
    updateProfilePic(url,context);
  }

  updateProfilePic(url,context) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {"profilePic": url},
    );
    notifyListeners();
    Navigator.pop(context);
  }
  cancelStreams(){
    userStream?.cancel();
    tripsStream?.cancel();
    notifyListeners();
  }
  Future<UserCredential?> signInWithFacebook(context) async {
    final fb = FacebookLogin();
    // Trigger the sign-in flow
    final loginResult = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    print(loginResult.status.toString());
    if (loginResult.status == FacebookLoginStatus.success) {
      print("success");
      final email = await fb.getUserEmail() ?? "";

      final image = await fb.getProfileImageUrl(width: 100);
      final profile = await fb.getUserProfile();
      final FacebookAccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(accessToken.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      notifyListeners();
      print(FirebaseAuth.instance.currentUser!.uid);
      print(FirebaseAuth.instance.currentUser!.uid);
      print(FirebaseAuth.instance.currentUser!.uid);
      print("facebook login");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(UserModel(
          email: email,
          uid: FirebaseAuth.instance.currentUser!.uid,
          profilePic: image!,
          userName: profile!.name!,
          dob: DateTime.now().millisecondsSinceEpoch)
          .toMap());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QuestionsScreen()));
    }
    // Create a credential from the access token
  }
  Future<bool> signInWithGoogle(BuildContext context,) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      print("this is mid");
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      print("google login");
      print(FirebaseAuth.instance.currentUser?.uid);
      print(FirebaseAuth.instance.currentUser?.uid);
      print(FirebaseAuth.instance.currentUser?.uid);
      print(FirebaseAuth.instance.currentUser?.uid);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(UserModel(
              email: user.email!,
              uid: user.uid,
              profilePic: user.photoURL!,
              dob: DateTime.now().millisecondsSinceEpoch,
              userName: user.displayName!)
              .toMap());
        }

        result = true;
        print(result);
        print("this is result");
      }
      return result;
    } catch (e) {
      print(e);
    }

    return result;
  }
  @override
  void dispose(){
    cancelStreams();
    print(FirebaseAuth.instance.currentUser?.uid);
        super.dispose();
  }
}
