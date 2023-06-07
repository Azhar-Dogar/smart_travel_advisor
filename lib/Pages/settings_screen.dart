import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/edit_profile.dart';
import 'package:smart_travel_advisor/Pages/splash_screen.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/widgets/drawer_widget.dart';
import 'package:smart_travel_advisor/widgets/loadingDialogue.dart';

import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProviderClass? provider;
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider <ProviderClass>(
      create: (context) => ProviderClass(),
      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.kWhiteColor, )),
          backgroundColor: Colors.green.shade500,
        title: Text("Settings", style: AppTextStyles.popins(
            style: const TextStyle(
              color: AppColors.kWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600
            )

          ),),
        ),
        body: SingleChildScrollView(child:
          Consumer<ProviderClass>(
            builder: (BuildContext context, value, Widget? child){
              provider = value;
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    ListTile(
                         // onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditProfile() )),
                          title: Text(
                            "Email", style: AppTextStyles.popins(
                              style: const TextStyle(
                                color: AppColors.kDarkColor,
                              )),),
                          subtitle: Text(
                              (value.user!=null)?(value.user!.email == "" )? "":
                              value.user!.email:""),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),

                  // User number and Language Builder

                  ListTile(
                    title: Text("Language ", style: AppTextStyles.popins(
                        style: const TextStyle(
                          color: AppColors.kDarkColor,
                        )),),
                    subtitle: Text("Default language" ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                  //  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const PatientRulesAndTerms() )),
                    title: Text("Rules and terms" , style: AppTextStyles.popins(
                        style: const TextStyle(
                          color: AppColors.kDarkColor,
                        )),),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  // logout Button
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: TextButton(
                        onPressed: () {
                          _showDialogueBox(context);
                        },
                        child: Text(
                          "Log out",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kPrimaryColor, fontSize: 16)),
                        )),
                  )
                ],
              );}
          ),
         ),
      ),
    );
  }

    Future<void> _showDialogueBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text("Do you want to log out?", style: AppTextStyles.popins(
               style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 16
               )
            ),),

            actions: [
              TextButton(
                  onPressed: () {
                     Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                  )),
              TextButton(
                  onPressed: ()  async {
                    await provider!.signOut(context);

                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                  )),
            ],
          ),
        );
      });
}
}