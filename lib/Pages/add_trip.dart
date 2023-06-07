import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';
import 'package:smart_travel_advisor/Pages/my_trips_screen.dart';
import 'package:smart_travel_advisor/Pages/saved_trips.dart';
import 'package:smart_travel_advisor/models/category_model.dart';
import 'package:smart_travel_advisor/models/myTrips_model.dart';
import 'package:smart_travel_advisor/models/searched_places.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';
import 'package:smart_travel_advisor/widgets/category_widget.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key, required this.locations});
  List<SearchedPlaces> locations;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? selectedValue;
    final List<String> items = ["Family", "Friends", "Adventure","Spiritual","Culture","Romantic","Nature","Leisure"];
  List<CategoryModel> categories = [
    CategoryModel(
        name: "Family",
        imageAddress: "assets/finalTrips/family.png",
        color: Colors.white),
    CategoryModel(
        name: "Friends",
        imageAddress: "assets/finalTrips/friends.png",
        ),
    CategoryModel(
        name: "Adventure",
        imageAddress: "assets/finalTrips/adventurer.png",
        ),
    CategoryModel(
        name: "Spiritual",
        imageAddress: "assets/finalTrips/spiritual.png",
        ),
    CategoryModel(
        name: "Culture",
        imageAddress: "assets/finalTrips/calture.png",
        ),
    CategoryModel(
        name: "Romantic",
        imageAddress: "assets/finalTrips/romance.png",
        ),
    CategoryModel(
        name: "Nature",
        imageAddress: "assets/finalTrips/nature.png",
        ),
    CategoryModel(
        name: "Leisure",
        imageAddress: "assets/finalTrips/leisure.png",
      )
  ];
  get screenHeight => MediaQuery.of(context).size.width;
  get screenWidth => MediaQuery.of(context).size.height;
  TextEditingController fieldController = TextEditingController();
  String categoryName = "";
  Color categoryColor = Colors.white;
  ProviderClass? provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Consumer<ProviderClass>(
          builder: (BuildContext context, value, Widget? child) {
        provider = value;
        return Stack(children: [
          CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                title: Text("Create Trip"),
              ),
              first(),
              categoryBuilder(),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  calculateDistance(),
                  editLocations(context),
                  SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  )
                ],
              )),
              locationsBuilder()
            ],
          ),
          Positioned(
              bottom: 0.1,
              child: continueButton(
                context,
              ))
        ]);
      }),
    );
  }
   Widget categoryBuilder(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Icon(
                      Icons.list,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.grey,
                buttonHeight: 50,
                buttonWidth: MediaQuery.of(context).size.width * 0.95,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.grey.shade200,
                ),
                buttonElevation: 0,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: MediaQuery.of(context).size.width,
                dropdownPadding: const EdgeInsets.all(12),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
              ),
            ),
      ),
    );
   }
  Widget locationsBuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.locations.length,
        (BuildContext context, int index) {
          return savedPlaces(widget.locations[index]);
        },
      ),
    );
  }
  Widget first() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
              child: Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      controller: fieldController,
                      decoration: const InputDecoration(hintText: "Trip Name"),
                    ),
                  ))),
           SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const Text(
            "Category",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    ));
  }

  Widget continueButton(
    BuildContext context,
  ) {
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
            onPressed: () async {
              if (fieldController.text.isEmpty || selectedValue == "") {
                errorMessage();
              } else {
                await provider!.addTrip(fieldController.text, selectedValue!,
                    widget.locations, context);
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                    ((route) => false));
                setState(() {
                  fieldController.clear();
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Trip",
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

  errorMessage() {
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please Enter Trip Info Properly")));
  }

  Widget savedPlaces(SearchedPlaces model, {String? count}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                ),
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
                              color: Colors.grey.shade600, fontSize: 12))),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 8, top: 3),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(
                             top: 0, bottom: 5, right: 3),
                         child: Text(
                           model.ratings.toString(),
                           style: AppTextStyles.popins(
                               style: TextStyle(
                                   color: Colors.yellow.shade900,
                                   fontSize: 12)),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: RatingStars(
                           value:model.ratings,
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
                          "(${ model.reviews})",
                           style: AppTextStyles.popins(
                               style: TextStyle(
                                   color: Colors.grey.shade700,
                                   fontSize: 10)),
                         ),
                       ),
                     ],
                   ),
                 ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget editLocations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Locations(${widget.locations.length})",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SavedTrips(locations:widget.locations,))),
            child: Text(
              "Edit Locations",
              style: AppTextStyles.popins(
                  style: TextStyle(
                      color: Colors.yellow.shade800,
                      fontWeight: FontWeight.w500,
                      fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget calculateDistance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Trip Distance",
                  style: AppTextStyles.popins(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 14))),
              Text("120 km",
                  style: AppTextStyles.popins(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 16))),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Trip Duration",
                  style: AppTextStyles.popins(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 13))),
              Text("5 Hr 30 Mins",
                  style: AppTextStyles.popins(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }

  Widget catagory(String text, image, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Container(
        decoration: BoxDecoration(
            color: color!, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.02,
              child: Image(image: AssetImage(image)),
            ),
            Text(
              text,
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
