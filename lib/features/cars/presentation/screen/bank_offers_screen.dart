import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bank_offer_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum SortOption { lowestMargin, highestMargin, lowestInstallment }

class BankOffersScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const BankOffersScreen({super.key, required this.car});

  @override
  State<BankOffersScreen> createState() => _BankOffersScreenState();
}

class _BankOffersScreenState extends State<BankOffersScreen> {
  late num _carPrice;
  double _downPayment = 0;
  int _durationYears = 5;
  SortOption _currentSort = SortOption.lowestMargin;

  final TextEditingController _downPaymentController = TextEditingController();

  final List<BankOffer> _allBanks = [
    BankOffer(
      nameKey: AppLocaleKey.bankAlrajhi,
      logoText: 'AR',
      apr: 3.5,
      brandColor: const Color(0xFF133261), // Al Rajhi Blue
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankSnb,
      logoText: 'SNB',
      apr: 2.9,
      brandColor: const Color(0xFF00755F), // SNB Green
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankRiyad,
      logoText: 'RB',
      apr: 3.2,
      brandColor: const Color(0xFFCE1126), // Riyad Bank Red
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankAlinma,
      logoText: 'INM',
      apr: 3.0,
      brandColor: const Color(0xFF886A34), // Alinma Gold
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankSab,
      logoText: 'SAB',
      apr: 3.4,
      brandColor: const Color(0xFFD61A0C), // SAB Red
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Use the car price or fallback to generic big number if null
    _carPrice = num.tryParse(widget.car['price'].toString().replaceAll(',', '')) ?? 150000;
  }

  @override
  void dispose() {
    _downPaymentController.dispose();
    super.dispose();
  }

  List<BankOffer> get _sortedOffers {
    final offers = List<BankOffer>.from(_allBanks);

    offers.sort((a, b) {
      if (_currentSort == SortOption.lowestMargin) {
        return a.apr.compareTo(b.apr);
      } else if (_currentSort == SortOption.highestMargin) {
        return b.apr.compareTo(a.apr);
      } else if (_currentSort == SortOption.lowestInstallment) {
        final calcA = a.calculate(_carPrice, _downPayment, _durationYears);
        final calcB = b.calculate(_carPrice, _downPayment, _durationYears);
        return calcA['monthlyInstallment']!.compareTo(calcB['monthlyInstallment']!);
      }
      return 0;
    });

    return offers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          AppLocaleKey.bankOffers.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildCalculatorSection(context),
          ),
          SliverToBoxAdapter(
            child: _buildFilterSection(context),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final offer = _sortedOffers[index];
                  return BankOfferCardWidget(
                    offer: offer,
                    carPrice: _carPrice,
                    downPayment: _downPayment,
                    durationYears: _durationYears,
                  );
                },
                childCount: _sortedOffers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocaleKey.totalAmount.tr()}:',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              Text(
                '${NumberFormat('#,##0', 'en_US').format(_carPrice)} SAR',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Text(
            AppLocaleKey.downPayment.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColor.blackTextColor(context),
            ),
          ),
          Gap(8.h),
          TextField(
            controller: _downPaymentController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColor.blackTextColor(context)),
            decoration: InputDecoration(
              hintText: '0 SAR',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: AppColor.scaffoldColor(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
            onChanged: (value) {
              setState(() {
                _downPayment = double.tryParse(value) ?? 0;
              });
            },
          ),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.durationInYears.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColor.blackTextColor(context),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$_durationYears',
                  style: TextStyle(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: _durationYears.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            activeColor: AppColor.primaryColor(context),
            inactiveColor: Colors.grey.withValues(alpha: 0.2),
            onChanged: (value) {
              setState(() {
                _durationYears = value.toInt();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.sortBy.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColor.blackTextColor(context),
            ),
          ),
          Gap(12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildSortChip(AppLocaleKey.lowestMargin.tr(), SortOption.lowestMargin, context),
                Gap(12.w),
                _buildSortChip(AppLocaleKey.highestMargin.tr(), SortOption.highestMargin, context),
                Gap(12.w),
                _buildSortChip(AppLocaleKey.lowestInstallment.tr(), SortOption.lowestInstallment, context),
              ],
            ),
          ),
          Gap(10.h),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, SortOption option, BuildContext context) {
    final isSelected = _currentSort == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentSort = option;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor(context) : AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.withValues(alpha: 0.2),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.whiteColor(context) : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
