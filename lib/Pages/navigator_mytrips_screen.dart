import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';

import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
   late GoogleMapController mapController;
  final LatLng _center = const LatLng(31.54505, 74.340683);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhiteColor,
              size: 16,
            )),
        title: Text(
          "JaiPur Road Trip",
          style: AppTextStyles.popins(
              style: const TextStyle(color: Colors.white, fontSize: 17)),
        ),
        actions: const [
          Icon(Icons.edit, size: 20,),
          Padding(
            padding: EdgeInsets.only(right: 14, left: 9),
            child: Icon(Icons.share, size: 20,),
          )
        ],
      ),

      body: Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
             googlemapWidget(),
             tripName(),
               Expanded(
                 child: ListView.builder(
                  itemCount: value.trips.length,
                   itemBuilder: (context,index) {
                     return savedPlaces("","","");
                   }
                 ),
               ),
          
          ],
        );}
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow.shade800,
          elevation: 2,
          onPressed: () {
           
          },
          child: const Icon(
            Icons.navigation,
            color: Color(0xFFFFFFFF),
            size: 26,
          )),
    );
  }

Widget googlemapWidget() {
    return SizedBox(
      height: 250,
      child: GoogleMap(
        myLocationEnabled: true,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
      ),
    );
  }

Widget tripName() {
    return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Locations(3)", style: AppTextStyles.popins(
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13
                )
              ),),
              Text("Advanture Trip", style: AppTextStyles.popins(
                style:  TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: 13
                )
              ),),
            ],
          ),
        );
  }

Widget savedPlaces(image, String heading, String details, ){
  return  Padding(
                padding: const EdgeInsets.only(left: 0, top: 3, right: 0),
                child: Container(
                 
                   decoration:  BoxDecoration( 
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                             ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 70,
                          height: 80,
                          decoration:   BoxDecoration(
                            image: DecorationImage(image: NetworkImage(image),fit:BoxFit.cover )
                             ),
                             ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 0, left: 7),
                            child: Text(heading, style: AppTextStyles.popins(
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                
                              )
                            ),),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 0, left: 7),
                            child: Text(
                               details , style: AppTextStyles.popins(
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 9
                                
                              )
                            )),
                          )
                        ],
                      )),
                    

                    ],
                  ),
                ),
              );
}
}