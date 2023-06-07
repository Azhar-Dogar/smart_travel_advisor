import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/widgets/places_widget.dart';

import '../models/searched_places.dart';

class ForesquareApiData extends StatefulWidget {
  ForesquareApiData({super.key,this.selectedLocations});
  List<SearchedPlaces>? selectedLocations =[];

  @override
  State<ForesquareApiData> createState() => _ForesquareApiDataState();
}

class _ForesquareApiDataState extends State<ForesquareApiData> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
      return Container(child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
        bool isAdded = false;
        value.locations.forEach((element) {
                            if (element.name == value.docList.last.name) {
                              isAdded = true;
                            }
                          });
        return PlacesWidget(
            places: value.docList.last, provider: value, isAdded: isAdded);
      }));
    });
  }
}
