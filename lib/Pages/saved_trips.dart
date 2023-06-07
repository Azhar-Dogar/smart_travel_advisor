import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/add_trip.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';

import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';
import 'attractions_screen.dart';

class SavedTrips extends StatefulWidget {
  SavedTrips({super.key, this.locations});
  List<SearchedPlaces>? locations = [];
  @override
  State<SavedTrips> createState() => _SavedTripsState();
}

class _SavedTripsState extends State<SavedTrips> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  late GoogleMapController mapController;
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

  final LatLng _center = const LatLng(31.54505, 74.340683);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  ProviderClass? provider;
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Consumer<ProviderClass>(
          builder: (BuildContext context, value, Widget? child) {
        provider = value;
        return Column(
          children: [
            googlemapWidget(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trip locations  (${widget.locations!.length})",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13))),
                        InkWell(
                          onTap: () {
                            if (widget.locations!.length == 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Already added 3 locations")));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AttractionsScreen(
                                            documentName: [widget
                                                .locations!.first.documentName],
                                            selectedLocations:widget.locations,
                                            provider: provider!,
                                          )));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "ADD Location ",
                                style: AppTextStyles.popins(
                                    style: TextStyle(
                                        color: Colors.yellow.shade800,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Icon(
                                Icons.add_box_rounded,
                                color: Colors.yellow.shade900,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: widget.locations!.length,
                          itemBuilder: (context, index) {
                            return savedPlaces(widget.locations![index],
                                button: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      setState(() {
                                        widget.locations!.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete)),
                                count: "${index + 1}");
                            ;
                          }),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          elevatedButtons("Share", onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please save a trip first")));
                          }),
                          elevatedButtons("Save", onPressed: () {
                            _showDialogueBoxSaveNow(context);
                          }),
                          elevatedButtons("Start", onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please save a trip first")));
                          })
                        ],
                      ))
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Widget elevatedButtons(String text, {required void Function()? onPressed}) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.31,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.yellow.shade800)),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14)),
          )),
    );
  }

  Widget savedPlaces(
    SearchedPlaces model, {
    String? count,
    IconButton? button,
    Color? containerColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: NetworkImage(model.imageUrl), fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    color: containerColor),
                child: Center(
                  child: Text(
                    (count == null) ? "" : count,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 0, left: 7),
                  child: Text(
                    model.name,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 0, left: 7),
                  child: Text(model.address,
                      style: AppTextStyles.popins(
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 11))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, bottom: 5, right: 3),
                        child: Text(
                          model.ratings.toString(),
                          style: AppTextStyles.popins(
                              style: TextStyle(
                                  color: Colors.yellow.shade900, fontSize: 12)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: RatingStars(
                          value: model.ratings,
                          starBuilder: (index, color) {
                            return Icon(
                              Icons.star_sharp,
                              color: color,
                              size: 15,
                            );
                          },
                          starCount: 5,
                          starSize: 15,
                          maxValue: 5,
                          starSpacing: 1,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          // animationDuration: Duration(milliseconds: 1000),
                          starOffColor: Colors.grey.shade400,
                          starColor: Colors.yellow.shade900,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, bottom: 5, left: 4),
                        child: Text(
                          "(${model.reviews})",
                          style: AppTextStyles.popins(
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            button!
          ],
        ),
      ),
    );
  }

  Widget googlemapWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: (currentLocation == null)
          ? Center(
            child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
          )
          : GoogleMap(
              myLocationEnabled: true,
              zoomGesturesEnabled: false,
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14.0,
              ),
              markers: _markers,
            ),
    );
  }

  Future<void> _showDialogueBoxSaveNow(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "Save it First !",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Before sharing, \nsave the trip",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 14)),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("close",
                        style: AppTextStyles.popins(
                          style: TextStyle(
                              color: Colors.yellow.shade800, fontSize: 14),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.yellow.shade800)),
                      onPressed: () async {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyWidget(
                                      locations: widget.locations!,
                                    )));
                      },
                      child: Text("Save Now",
                          style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ))),
                )
              ],
            ),
          );
        });
  }
}
