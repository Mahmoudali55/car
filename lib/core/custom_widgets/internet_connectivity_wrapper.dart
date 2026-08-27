import 'package:flutter/material.dart';

class InternetConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const InternetConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
