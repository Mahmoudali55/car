import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/home/presentation/view/widgets/offer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersGridWidget extends StatelessWidget {
  const OffersGridWidget({super.key});

  static const List<Map<String, dynamic>> _offers = [
    {
      'name': 'G63 AMG 2024',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/car.jpeg',
      'price': '850,000',
      'oldPrice': '1,000,000',
      'installments': '1,166',
      'cashPrice': '850,000',
      'discount': '15%',
      'year': '2024',
      'mileage': '0',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'M5 Competition',
      'brand': 'BMW',
      'image': 'assets/images/car.jpeg',
      'price': '440,000',
      'oldPrice': '520,000',
      'installments': '1,166',
      'cashPrice': '440,000',
      'discount': '10%',
      'year': '2023',
      'mileage': '5,000',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
    {
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'image': 'assets/images/car.jpeg',
      'price': '330,000',
      'oldPrice': '350,000',
      'installments': '1,166',
      'cashPrice': '330,000',
      'discount': '5%',
      'year': '2024',
      'mileage': '0',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'image': 'assets/images/car.jpeg',
      'price': '450,000',
      'oldPrice': '480,000',
      'installments': '1,166',
      'cashPrice': '450,000',
      'discount': '7%',
      'year': '2024',
      'mileage': '0',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet || context.isDesktop;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: isTablet ? 0.75 : 0.63,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) => OfferCard(car: _offers[index]),
    );
  }
}
