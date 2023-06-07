import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:smart_travel_advisor/Pages/edit_profile.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';
import 'package:smart_travel_advisor/Pages/settings_screen.dart';
import 'package:smart_travel_advisor/Pages/support_screen.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

import '../Pages/create_trip_screen.dart';
import '../Pages/my_trips_screen.dart';
import '../Pages/splash_screen.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({Key? key}) : super(key: key);

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
      return Drawer(
        child:SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                        
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 25,
                          color: Colors.white
                        )
                        )
                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                       (value.user != null)
                         ? value.user!.profilePic
                         :
                           "https://media.istockphoto.com/id/1214428300/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=vftMdLhldDx9houN4V-g3C9k0xl6YeBcoB_Rk6Trce0=")),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (value.user != null) ? value.user!.userName : "",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            size: 26,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child:
                    drawerMenu("Create Trip", Icons.add_box_rounded, onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()));
                }),
              ),
              drawerMenu("My Trips", Icons.donut_large_outlined, onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()));
              }),
              drawerMenu("Support", Icons.call, onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SupportScreen()));
              }),
              drawerMenu("My Account", Icons.person, onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => EditProfile()));
              }),
              drawerMenu("Invite", Icons.group_add, onTap: () {
                Navigator.pop(context);
                Share.share(
                        " https://play.google.com/store/apps/details?id=com.example.smart_travel_advisor ");
              }
               ),
              drawerMenu("Rate Us", Icons.thumb_up ),
              drawerMenu("Settings", Icons.settings, onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SettingsScreen()));
              })
            ],
          ),
        ),
      );
    });
  }

  Widget drawerMenu(String name, IconData icon, {void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 30),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: AppColors.kPrimaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                name,
                style:
                    AppTextStyles.popins(style: const TextStyle(fontSize: 15)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
