import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/functions/functions.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:smart_travel_advisor/widgets/alert_dialogue_widget.dart';
import 'package:smart_travel_advisor/widgets/drawer_widget.dart';

import '../models/user_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
setState(() {
   dob = DateFormat('dd-MM-yyyy')
      .format(DateTime.now());
});
  }
  String dob = "";
  ProviderClass? provider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      //drawer: const DrawerClass(),
      body: Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
          provider = value;
          DateTime dob = DateTime.fromMillisecondsSinceEpoch(value.user!.dob);
         String birthDate = DateFormat('dd-MM-yyyy')
              .format(dob);
          return  SingleChildScrollView (
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.09,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (value.user?.profilePic == null)?
                    CircleAvatar(

                    ):
                    InkWell(
                      onTap: (){
                        value.getImage(context);
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(value.user!.profilePic),
                        radius: 60,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(

                        (value.user?.userName == null)?
                            "":
                        value.user!.userName,
                        style: AppTextStyles.popins(
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 6),
                        child: InkWell (
                          onTap: (){
                             showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogueClass(
                                      title: "userName",
                                      provider: value,
                                      value: value.user!.userName));
                          },
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.edit,
                                  size: 17,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              Container(
                                height: 1,
                                width: 9,
                                color: AppColors.kPrimaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height*0.015,
                      ),
                      details(
                          name: "Email Address",
                          value: value.user!.email,
                          icon: Icons.email,

                          onTap: (){
                          //  AlertDialogueClass(provider: ProviderClass(), title: '', value: '',);
                          }
                          ),

                      details(
                        name: "Date of Birth",
                        value: birthDate,
                        icon: Icons.cake,
                        edit: Icons.edit,
                          onTap: ()async{
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if(newDate!=null){
                              Functions.showLoaderDialog(context);
                             await value.updateProfile("dob", newDate.millisecondsSinceEpoch);
                             Navigator.pop(context);
                            }
                          }
                      ),

                        details(
                        name: "Country",
                        value: "Pakistan",
                        icon: Icons.public,
                      ),
                      SizedBox(
                        height: height*0.015,
                      ),
                    ],
                  ),
                ),

                 SizedBox(height: height *0.02,),
                 Card(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      details(
                          name: "Total Trips",
                          value:value.trips.length.toString(),
                          icon: Icons.donut_large_outlined,

                          ),

                      details(
                        name: "Places visited",
                        value: "${value.totalLocations.length}",
                        icon: Icons.location_on,

                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget details({required String name, required String value, required IconData icon, void Function()? onTap, IconData? edit,   }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.popins(
                    style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13
                  ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(value, style: AppTextStyles.popins(
                    style: const TextStyle(
                      fontSize: 12
                    )
                  ), ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21, left: 2, ),
            child: InkWell(
              onTap: 
                onTap,
              
                child:  Icon(
              edit,
              size: 13,
              color: AppColors.kPrimaryColor,
            )),
          )
        ],
      ),
    );
  }

}
