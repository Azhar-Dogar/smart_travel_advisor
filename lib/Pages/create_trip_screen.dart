import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/drop_down_text_field.dart';
import 'package:smart_travel_advisor/models/search_categories.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:smart_travel_advisor/widgets/text_field_widget.dart';

import 'attractions_screen.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  get screenHeight => MediaQuery.of(context).size.width;
  get screenWidth => MediaQuery.of(context).size.height;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  late GoogleMapController mapController;
  TextEditingController destinationController = TextEditingController();
  TextEditingController topAttraationsController = TextEditingController();
  List<String> categoriesList = [
    "Park",
    "Restaurant",
    "Historical Place",
  ];
  String temp = '';
  String selectedValue = "";
  List<SearchCategories> searchedItems = [];
  final LatLng _center = const LatLng(31.582045, 74.329376);
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
      currentLocation = location;
      _markers.add(Marker(markerId: MarkerId("markerId"),
      position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
      ));
    });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final Set<Marker> _markers = {};
  ProviderClass? provider;

  @override
  Widget build(BuildContext context) {
    return (currentLocation == null)
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
              
            ),
          )
        : Stack(
            children: [
              GoogleMap(
               // indoorViewEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
                  zoom: 15.0,
                ),
             //   markers:_markers
              ),
              Positioned(
                  top: 35,
                  left: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      searchTextFields(
                          "Enter Destination", destinationController,
                          locationIcon: Icons.location_on_rounded),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      //dropDownTextField(selectedValue,categoriesList),
                      DropDownTextField(
                        selectedValue: selectedValue,
                      )
                    ],
                  ))
            ],
          );
  }

  // seaching textfields
  Widget searchTextFields(String hinttext, TextEditingController controller,
      {IconData? locationIcon, void Function(String)? onChanged}) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 30)
            ]),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
              suffixIcon: Icon(locationIcon),
              suffixIconColor: Colors.grey.shade100,
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                size: 23,
              ),
              hintText: hinttext,
              hintStyle: AppTextStyles.popins(
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 14,
                      color: Colors.grey.shade500))),
        ));
  }


}
