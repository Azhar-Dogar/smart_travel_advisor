import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/start_trip.dart';
import 'package:smart_travel_advisor/models/myTrips_model.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

import '../provider/provider_class.dart';

class MyTripsscreen extends StatefulWidget {
  const MyTripsscreen({super.key});

  @override
  State<MyTripsscreen> createState() => _MyTripsscreenState();
}

class _MyTripsscreenState extends State<MyTripsscreen> {
  ProviderClass? provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
      provider = value;
      return ListView.builder(
          itemCount: value.trips.length,
          itemBuilder: (context, index) {
            return myTrips(value.trips[index], value);
          });
    });
  }

  Widget myTrips(MyTrips trip, ProviderClass provider) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Slidable(
        endActionPane:
            ActionPane(extentRatio: 0.2, motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (v) async {
              await provider.deleteTrip(trip.tripId, context);
            },
            borderRadius: BorderRadius.circular(16),
            label: "Delete",
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ]),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    spreadRadius: 2)
              ]),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 2,
                          spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                          trip.tempList!.first.imageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                  width: 80,
                  height: 80,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      trip.tripName,
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      "Locations (${trip.tempList!.length})",
                      style: AppTextStyles.popins(
                          style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, left: 15),
                    child: Text(
                      trip.category,
                      style: AppTextStyles.popins(
                          style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "5 Days",
                        style: AppTextStyles.popins(
                            style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 13),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => StartTripScreen(
                                          trip: trip,
                                        )));
                          },
                          child: Text(
                            "Start Trip",
                            style: AppTextStyles.popins(
                                style: TextStyle(
                              color: Colors.yellow.shade900,
                              fontSize: 14,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
