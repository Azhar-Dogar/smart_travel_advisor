import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/saved_trips.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:smart_travel_advisor/widgets/foresquare_api.dart';
import 'package:smart_travel_advisor/widgets/google_api_data.dart';
import 'package:smart_travel_advisor/widgets/yelp_api.dart';

import '../provider/provider_class.dart';
import '../widgets/places_widget.dart';

class AttractionsScreen extends StatefulWidget {
  AttractionsScreen(
      {super.key, required this.documentName,this.provider, this.selectedLocations});
  List<String> documentName;
  ProviderClass? provider;
  List<SearchedPlaces>? selectedLocations = [];
  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen>
    with TickerProviderStateMixin {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(31.54505, 74.340683);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<SearchedPlaces> temp = [];
  double ratingValue = 4.3;
  bool isAdded = false;
  bool isCheck = false;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    getCurrentLocation();
    super.initState();
  }

  final Set<Marker> _markers = {};
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
        _markers.add(Marker(
            markerId: MarkerId("markerId"),
            position: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!)));
      });
    });
  }

  ProviderClass? provider;
  List<SearchedPlaces> locations = [];
  List<SearchedPlaces> docList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhiteColor,
              size: 21,
            )),
        title: Text(
          "Create Trip",
          style: AppTextStyles.popins(
              style: const TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProviderClass(),
        child: Consumer<ProviderClass>(
            builder: (BuildContext context, value, Widget? child) {
          provider = value;
          print(value.places.length);
          value.getCurrentDoc(widget.documentName);
          return (currentLocation == null)
              ?  Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                )
              : Column(
                  children: [
                    googlemapWidget(),
                    tabbarWidget(),
                    const SizedBox(height: 5),
                    (value.docList.isEmpty)?Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: Text("No place to show",style: TextStyle(fontSize: 20),),
                    ):
                   Expanded(child:  TabBarView(
                      controller: tabController,
                      children: [
                          
                          GoogleApiData(selectedLocations:widget.selectedLocations,),
                          ForesquareApiData(selectedLocations:widget.selectedLocations,),
                          YelpApiData(selectedLocations:widget.selectedLocations,),
                    ]),)
                   ,(value.docList.isEmpty)? Container():continueButton(context, value)
                  ],
                );
        }),
      ),
    );
  }

  Widget continueButton(BuildContext context, value) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.yellow.shade500,
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.yellow.shade800)),
            onPressed: () {
              if (provider!.locations.isNotEmpty) {
                temp = provider!.locations;
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedTrips(
                              locations: temp,
                            )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select location")));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue (${provider!.locations.length.toString()})",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.navigate_next)
              ],
            )),
      ),
    );
  }

  Widget googlemapWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32 ,
      child: GoogleMap(
        myLocationEnabled: true,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        rotateGesturesEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 14.0,
        ),
        markers: _markers,
      ),
    );
  }

  Widget tabbarWidget() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 2),
      ]),
      child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: const Color(0xFF000000),
          unselectedLabelColor: Colors.grey.shade600,
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 5.0, color: Color(0xFF0EA102)),
            insets: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          tabs: const [
            Tab(
              text: 'GOOGLE',
            ),
            Tab(
              text: 'FORESQUARE',
            ),
            Tab(
              text: 'YELP',
            ),
          ]),
    );
  }
}
