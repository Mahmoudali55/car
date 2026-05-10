import 'package:flutter/material.dart';

class AdItem {
  final String title;
  final String subtitle;
  final String tag;
  final String price;
  final String image;
  final Color accentColor;
  final List<Color> bgColors;

  const AdItem({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.price,
    required this.image,
    required this.accentColor,
    required this.bgColors,
  });
}
