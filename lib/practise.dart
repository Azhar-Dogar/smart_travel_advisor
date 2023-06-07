import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

import 'Pages/home_page.dart';


class AttendusPage extends StatefulWidget {
  const AttendusPage({Key? key}) : super(key: key);

  @override
  State<AttendusPage> createState() => _AttendusPageState();
}

class _AttendusPageState extends State<AttendusPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize (
        preferredSize: const Size.fromHeight(70),
        child: appBarWidget()
      ),
            backgroundColor: Colors.grey[200],
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: Text("Today's Shift",style: AppTextStyles.popins(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                     // fontWeight: FontWeight.w500
                    )
                  ), ),
                )
              ],
            )
    );
  }

// AppBar Widget
 Widget appBarWidget(){
    return AppBar(
          backgroundColor: Colors.blue,
          title: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text("Dashboard", style: AppTextStyles.popins(
              style: TextStyle(
                color: AppColors.kWhiteColor,
                fontWeight: FontWeight.w500
              )
            ) ),
          ),
        );
  }



  Widget dateTime(){
    String? formattedTime;
     setState(() {
      DateTime now = DateTime.now();
     formattedTime = DateFormat.Hm().format(now);
    });
    return Text("${formattedTime.toString()} AM");
   
  }
  
 
}