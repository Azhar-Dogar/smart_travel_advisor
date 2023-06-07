import 'package:smart_travel_advisor/models/searched_places.dart';

class MyTrips {
  MyTrips(
      {required this.tripName,
       required this.locations,
        required this.category,
        required this.tripId,
        this.tempList});
  String tripName;
  String category;
  String tripId;
  List locations = [];
  List<SearchedPlaces>? tempList = [];
  static MyTrips fromMaP(Map<String, dynamic> data) => MyTrips(
      tripName: data["tripName"],
      locations: data["locations"],
      tripId: data["tripId"],
      category: data["category"]);
  toMap() => {"tripName": tripName,
    "tripId":tripId,
   "address": category, "locations":locations};
}
