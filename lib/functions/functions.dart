import 'package:flutter/material.dart';
import 'package:smart_travel_advisor/services/utils/app_colors.dart';

class Functions{
  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration:
        const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppColors.kBackgroundColor,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "$text...",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




}