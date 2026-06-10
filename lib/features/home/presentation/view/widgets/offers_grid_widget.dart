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
      'image':
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=1000&auto=format&fit=crop',
      'price': '850,000',
      'oldPrice': '1,000,000',
      'installments': '12,500',
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
      'image':
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=1000&auto=format&fit=crop',
      'price': '440,000',
      'oldPrice': '520,000',
      'installments': '6,800',
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
      'image':
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=1000&auto=format&fit=crop',
      'price': '330,000',
      'oldPrice': '350,000',
      'installments': '5,200',
      'cashPrice': '330,000',
      'discount': '5%',
      'year': '2024',
      'mileage': '0',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Ferrari SF90',
      'brand': 'Ferrari',
      'image':
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=1000&auto=format&fit=crop',
      'price': '1,800,000',
      'oldPrice': '2,100,000',
      'installments': '28,500',
      'cashPrice': '1,800,000',
      'discount': '14%',
      'year': '2024',
      'mileage': '0',
      'engine': '4.0L V8 Hybrid',
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
        childAspectRatio: isTablet ? 0.75 : 0.58,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) => OfferCard(car: _offers[index]),
    );
  }
}
