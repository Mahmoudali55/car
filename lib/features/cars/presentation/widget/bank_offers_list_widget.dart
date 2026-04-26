import 'package:car/features/cars/presentation/widget/bank_offer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankOffersList extends StatelessWidget {
  final List<BankOffer> sortedOffers;
  final num carPrice;
  final double downPayment;
  final int durationYears;
  final Function(BankOffer)? onOfferTap;
  const BankOffersList({
    super.key,
    required this.sortedOffers,
    required this.carPrice,
    required this.downPayment,
    required this.durationYears,
    this.onOfferTap,
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
              onTap: onOfferTap != null ? () => onOfferTap!(offer) : null,
            );
          },
          childCount: sortedOffers.length,
        ),
      ),
    );
  }
}
