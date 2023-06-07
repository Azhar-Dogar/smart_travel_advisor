import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_advisor/models/myTrips_model.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:share/share.dart';
import '../services/utils/app_colors.dart';

class StartTripScreen extends StatefulWidget {
  StartTripScreen({Key? key, required this.trip}) : super(key: key);
  MyTrips trip;
  @override
  State<StartTripScreen> createState() => _StartTripScreenState();
}

class _StartTripScreenState extends State<StartTripScreen> {
  @override
  Completer<GoogleMapController> _mapController = Completer();

  double lat = 0.0;
  double long = 0.0;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> tempLoc = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      lat = widget.trip.tempList!.first.latitude;
      long = widget.trip.tempList!.first.longitude;
    });
    for (int i = 0; i < widget.trip.tempList!.length; i++) {
      tempLoc.add(LatLng(widget.trip.tempList![i].latitude,
          widget.trip.tempList![i].longitude));
      print(tempLoc[i].latitude);
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(widget.trip.tempList![i].latitude,
              widget.trip.tempList![i].longitude),
          infoWindow: InfoWindow(title: widget.trip.tempList![i].name),
          icon: BitmapDescriptor.defaultMarker));
      setState(() {});

      _polyline.add(Polyline(
          polylineId: PolylineId("1"),
          color: Colors.yellow.shade900,
          points: tempLoc,
          width: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Back",
            style: AppTextStyles.popins(style: TextStyle(fontSize: 14)),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                Share.share(""" Trip Name: ${widget.trip.tripName}
Locations:
Starting Point: ${widget.trip.tempList!.first.name}
Ending Point: ${widget.trip.tempList!.last.name}

""");
              },
            )
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, long),
                zoom: 10,
              ),
              markers: _markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              tiltGesturesEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              polylines: _polyline,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.kPrimaryColor)),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "End Navigation ",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  )),
            ),
          ],
        ));
  }
}
