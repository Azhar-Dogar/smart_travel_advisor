import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget(
      {super.key,
      required this.provider,
      required this.imageAddress,
      required this.isSelected,
      this.color,
      this.onTap,
      required this.name});
  void Function()? onTap;
  String imageAddress;
  String name;
  bool isSelected;
  ProviderClass provider;
  Color? color;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  get screenHeight => MediaQuery.of(context).size.width;
  get screenWidth => MediaQuery.of(context).size.height;
  Color categoryColor = Colors.red;
  @override
  void initState() {
    print("this is helo");
    // TODO: implement initState
    print("object");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 3),
        child: Container(
          decoration: BoxDecoration(
              color:widget.color,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.02,
                child: Image(image: AssetImage(widget.imageAddress)),
              ),
              Text(
                widget.name,
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
      ),
    );
    ;
  }
}
