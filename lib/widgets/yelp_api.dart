import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/widgets/places_widget.dart';

import '../models/searched_places.dart';
import '../provider/provider_class.dart';
class YelpApiData extends StatefulWidget {
  YelpApiData({super.key, this.selectedLocations});
  List<SearchedPlaces>? selectedLocations =[];

  @override
  State<YelpApiData> createState() => _YelpApiDataState();
}

class _YelpApiDataState extends State<YelpApiData> {
  @override
  Widget build(BuildContext context) {
        return Consumer<ProviderClass>(
        builder: (BuildContext context, value, Widget? child) {
      return Container(child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
        bool isAdded = false;
         value.locations.forEach((element) {
                            if (element.name == value.docList.first.name) {
                              isAdded = true;
                            }
                          });
        return PlacesWidget(
            places: value.docList.first, provider: value, isAdded: isAdded);
      }));
    });
  }
}