import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/attractions_screen.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

class DropDownTextField extends StatefulWidget {
  DropDownTextField({Key? key, required this.selectedValue}) : super(key: key);
  String selectedValue;
  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  final List<String> items = ["Park", "Restaurant", "Historical Place","Cafe","Cinema"];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Top Attractions',
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
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
            ),
            buttonElevation: 2,
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
        const SizedBox(
          height: 20,
        ),
        Consumer<ProviderClass>(
          builder: (BuildContext context, value, Widget? child) {
            return searchButton(value);
          },
        )
      ],
    );
  }

  Widget searchButton(ProviderClass provider) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 30)
          ]),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),
          onPressed: () {
            if (selectedValue != null) {
              provider.getTrips();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => Consumer<ProviderClass>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  AttractionsScreen(
                                    documentName: [selectedValue!],
                                    provider:provider
                                  ))));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select item")));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.5),
            child: Text(
              "Search",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          )),
    );
  }
}
