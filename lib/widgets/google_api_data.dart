import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/widgets/places_widget.dart';

import '../models/searched_places.dart';
class GoogleApiData extends StatefulWidget {
 GoogleApiData({super.key,this.selectedLocations});
List<SearchedPlaces>? selectedLocations =[];
  @override
  State<GoogleApiData> createState() => _GoogleApiDataState();
}

class _GoogleApiDataState extends State<GoogleApiData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is google");
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
      builder: (BuildContext context, value, Widget? child) {
      return Container(
        child: ListView.builder(
                          itemCount: value.docList.length,
                          itemBuilder: (BuildContext context, int index) {
                          bool  isAdded = false;
                            value.locations.forEach((element) {
                              if (element.name == value.docList[index].name) {
                                isAdded = true;
                              }
                            });
                            return PlacesWidget(
                              places: value.docList[index],
                              provider: value,
                              isAdded: isAdded,
                            );
                          },
                        ),
      );}
    );
  }
}