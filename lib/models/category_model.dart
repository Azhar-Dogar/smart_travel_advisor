import 'package:flutter/material.dart';

class CategoryModel{
  CategoryModel({
    required this.name,
    required this.imageAddress,
    this.color
  });
  Color? color;
  String name;
  String imageAddress;
}