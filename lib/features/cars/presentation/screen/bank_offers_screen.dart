import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bank_offer_card_widget.dart';
import 'package:car/features/cars/presentation/widget/bank_offers_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
            child: BankOfferCalculatorCard(
              carPrice: _carPrice,
              downPayment: _downPayment,
              durationYears: _durationYears,
              downPaymentController: _downPaymentController,
              onDownPaymentChanged: (value) {
                setState(() {
                  _downPayment = double.tryParse(value) ?? 0;
                });
              },
              onDurationChanged: (value) {
                setState(() {
                  _durationYears = value.toInt();
                });
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BankOfferFilterSection(
              currentSort: _currentSort,
              onSortChanged: (option) {
                setState(() {
                  _currentSort = option;
                });
              },
            ),
          ),
          BankOffersList(
            sortedOffers: _sortedOffers,
            carPrice: _carPrice,
            downPayment: _downPayment,
            durationYears: _durationYears,
          ),
        ],
      ),
    );
  }
}
