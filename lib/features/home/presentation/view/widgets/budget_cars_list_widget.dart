import 'package:car/features/home/presentation/view/widgets/horizontal_car_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetCarsListWidget extends StatelessWidget {
  final int selectedBudgetIndex;
  
  const BudgetCarsListWidget({
    super.key,
    required this.selectedBudgetIndex,
  });

  // Dummy data categorized by budget index
  static final List<List<Map<String, dynamic>>> budgetData = [
    // index 0: Under 50k (or < 1000 installment)
    [
      {
        'name': 'Toyota Yaris 2024',
        'image': 'assets/images/cars/toyota.png',
        'cashPrice': '45,000 SAR',
        'installmentPrice': '850 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': true,
      },
      {
        'name': 'Hyundai Accent 2023',
        'image': 'assets/images/cars/hyundai.png',
        'cashPrice': '48,500 SAR',
        'installmentPrice': '920 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': false,
      },
    ],
    // index 1: 50k-100k
    [
      {
        'name': 'Camry SE 2024',
        'image': 'assets/images/cars/toyota.png',
        'cashPrice': '95,000 SAR',
        'installmentPrice': '1,450 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': true,
      },
      {
        'name': 'Kia K5 2024',
        'image': 'assets/images/cars/kia.png',
        'cashPrice': '88,000 SAR',
        'installmentPrice': '1,320 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': true,
      },
    ],
    // index 2: 100k-200k
    [
      {
        'name': 'Lexus ES 350',
        'image': 'assets/images/cars/lexus.png',
        'cashPrice': '185,000 SAR',
        'installmentPrice': '2,800 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': false,
      },
      {
        'name': 'Ford Explorer 2024',
        'image': 'assets/images/cars/ford.png',
        'cashPrice': '165,000 SAR',
        'installmentPrice': '2,400 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': true,
      },
    ],
    // index 3: Over 200k
    [
      {
        'name': 'Ferrari SF90',
        'image': 'assets/images/cars/mercedes-benz.png',
        'cashPrice': '1,200,000 SAR',
        'installmentPrice': '18,500 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': false,
      },
      {
        'name': 'Range Rover Vogue',
        'image': 'assets/images/cars/landrover.png',
        'cashPrice': '750,000 SAR',
        'installmentPrice': '11,200 SAR/mo',
        'installments': '1,166 ر.س / شهر',
        'isTamaraAvailable': true,
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final cars = budgetData[selectedBudgetIndex % budgetData.length];

    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return HorizontalCarCardWidget(car: cars[index]);
        },
      ),
    );
  }
}
