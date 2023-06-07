import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';
import 'package:smart_travel_advisor/services/utils/app_test_styles.dart';

class TextFieldWidget extends StatefulWidget {
   TextFieldWidget({super.key,required this.controller,required this.hinttext,this.locationIcon,this.onChanged});
String hinttext; 
TextEditingController controller;
  IconData? locationIcon; 
  void Function(String)? onChanged;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 310,
        height: 48,
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 30)
            ]),
        child: TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              suffixIcon: Icon(widget.locationIcon),
              suffixIconColor: Colors.grey.shade100,
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                size: 23,
              ),
              hintText: widget.hinttext,
              hintStyle: AppTextStyles.popins(
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 14,
                      color: Colors.grey.shade500))),
        ));;
  }
}