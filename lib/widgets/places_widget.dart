import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';

import '../provider/provider_class.dart';
import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';

class PlacesWidget extends StatefulWidget {
  PlacesWidget(
      {Key? key,
      required this.places,
      required this.provider,
      required this.isAdded})
      : super(key: key);
  SearchedPlaces places;
  ProviderClass provider;
  bool isAdded;
  @override
  State<PlacesWidget> createState() => _PlacesWidgetState();
}

class _PlacesWidgetState extends State<PlacesWidget> {
  bool isCheck = false;
  double ratingValue = 4.3;
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 2)
        ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, top: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(widget.places.imageUrl),
                        fit: BoxFit.cover),
                  ),
                  //width: 80,
                  //height: 80,
                 width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.11
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start  ,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.places.name,
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kDarkColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Align (
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () => setState(() {
                                isCheck = !isCheck;
                              }),
                              child: (isCheck)
                                  ? Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                      color: Colors.grey.shade700,
                                    )
                                  : Icon(
                                      Icons.arrow_drop_down,
                                      size: 25,
                                      color: Colors.grey.shade700,
                                    ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        widget.places.address,
                        style: AppTextStyles.popins(
                            style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        )),
                      ),
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 5, right: 3),
                                child: Text(
                                  widget.places.ratings.toString(),
                                  style: AppTextStyles.popins(
                                      style: TextStyle(
                                          color: Colors.yellow.shade900,
                                          fontSize: 12)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: RatingStars(
                                  value:widget.places.ratings,
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
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 5, left: 4),
                                child: Text(
                                  "(${widget.places.reviews})",
                                  style: AppTextStyles.popins(
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10)),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, right: 0, left: 30),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                width: 90,
                                height: 30,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        backgroundColor: MaterialStateProperty.all(
                                            (isAdded)
                                                ? Colors.yellow
                                                : AppColors.kPrimaryColor)),
                                    onPressed: () async {
                                      if (widget.isAdded == true ||
                                          widget.provider.locations.length >= 3) {
                                            if(widget.provider.locations.length >= 3){
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already added 3 locations")));
                                      } }else {
                                        widget.provider.addLocation(widget.places);
                                       }
                                    },
                                    child: (widget.isAdded==true)
                                        ? Text(
                                            "Added",
                                            style: AppTextStyles.popins(
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold)),
                                          )
                                        : Text(
                                            "Add to Trip",
                                            style: AppTextStyles.popins(
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold)),
                                          ))),
                          )
                        ],
                      ),
                      if (isCheck) additionalDetails(),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget additionalDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              openingDetailsText("Hours: ", widget.places.hours),
              openingDetailsText("phone: ", widget.places.phoneNumber),
              openingDetailsText("opening Hours: ", widget.places.hours)
            ],
          )
        ],
      ),
    );
  }

  Widget openingDetailsText(String hours, String details) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: hours,
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              children: [
                TextSpan(
                  text: details,
                  style: AppTextStyles.popins(
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                ),
              ])),
    );
  }
}
