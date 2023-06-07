import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:smart_travel_advisor/Pages/create_trip_screen.dart';
import 'package:smart_travel_advisor/Pages/my_trips_screen.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:smart_travel_advisor/widgets/drawer_widget.dart';

import '../provider/provider_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

@override
late TabController _tabController;

  @override
  void initState() {
    setState(() {

    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderClass> (
      create: (context) => ProviderClass(),
      child: Consumer<ProviderClass> (
        builder: (context, value, child) =>
        Scaffold(
          backgroundColor: Colors.grey.shade300,
          drawer: const DrawerClass(),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: appbarWidget()

            ),

  body: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              CreateTripScreen(),
              MyTripsscreen(),
            ],
          )
        ),
      ),
    );
  }

Widget appbarWidget (){
  return AppBar(
              centerTitle: true,
            title: Text("Travel Advisor",  style: AppTextStyles.popins(
              style: const TextStyle(
                color: AppColors.kWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w700
              )
            ),),
              actions: <Widget>[
    IconButton(
      icon: const Icon(
        Icons.group_add,
        color: Colors.white,
      ),
      onPressed: () {
         Share.share(
              " https://play.google.com/store/apps/details?id=com.example.smart_travel_advisor ");
              
      },
    )
  ],
  bottom: TabBar(
     indicatorSize: TabBarIndicatorSize.label, 
     unselectedLabelColor: Colors.white60,
     
     padding: EdgeInsets.all(0),
          controller: _tabController,
          tabs:  <Widget>[
            Tab(
              child: Text("Create Trip", style: AppTextStyles.popins(
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
          
                )
              ),),
            ),
            Tab(
              child: Text("My Trips", style: AppTextStyles.popins(
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
          
                )
              ),),
            ),
           
          ],
        ),   
          );
}
}