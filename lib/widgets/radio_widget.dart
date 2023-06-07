import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';

import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';

class RadioWidget extends StatefulWidget {
  RadioWidget({Key? key,required this.value,required this.provider}) : super(key: key);
ProviderClass provider;
int? value;
  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue:value,
            title: Align(
              alignment: Alignment(-3.2, 0),
              child: Text(
                "Yes",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 12)),
              ),
            ),
            onChanged: (newValue) {

            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: value,
            title: Align(
              alignment: const Alignment(-1.4, 0),
              child: Text(
                "No",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 12)),
              ),
            ),
            onChanged: (newValue) {

            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }
}
