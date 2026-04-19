import 'package:car/features/cars/presentation/widget/bank_offer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankOffersList extends StatelessWidget {
  final List<BankOffer> sortedOffers;
  final num carPrice;
  final double downPayment;
  final int durationYears;
  const BankOffersList({
    super.key,
    required this.sortedOffers,
    required this.carPrice,
    required this.downPayment,
    required this.durationYears,
  });
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final offer = sortedOffers[index];
            return BankOfferCardWidget(
              offer: offer,
              carPrice: carPrice,
              downPayment: downPayment,
              durationYears: durationYears,
            );
          },
          childCount: sortedOffers.length,
        ),
      ),
    );
  }
}
