import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: const Text('Track Order')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset('assets/images/picture.png'),
              SizedBox(height: 16),
              Text(
                'Your order tracking details will be available soon.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
