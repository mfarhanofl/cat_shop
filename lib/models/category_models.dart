import 'package:flutter/material.dart';

class CategoryModels {
  final IconData? icon;
  final String text;
  CategoryModels({required this.icon, required this.text});
}

List<CategoryModels> cat = [
  CategoryModels(icon: Icons.all_out_outlined, text: 'All'),
  CategoryModels(icon: Icons.laptop_mac, text: 'Laptop'),
  CategoryModels(icon: Icons.phone_android, text: 'Smartphone'),
  CategoryModels(icon: Icons.tablet, text: 'Tablet'),
  CategoryModels(icon: Icons.tv, text: 'TV'),
];
