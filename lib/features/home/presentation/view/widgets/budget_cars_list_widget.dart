import 'package:car/core/images/app_images.dart';
import 'package:car/features/home/presentation/view/widgets/horizontal_car_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetCarsListWidget extends StatelessWidget {
  final int selectedBudgetIndex;

  const BudgetCarsListWidget({super.key, required this.selectedBudgetIndex});

  // Real car data categorized by budget index
  static final List<List<Map<String, dynamic>>> budgetData = [
    // index 0: Under 1000 SAR installment
    [
      {
        'name': 'Toyota Yaris 2024',
        'image': AppImages.assetsImagesYaris,
        'cashPrice': '65,000 SAR',
        'installmentPrice': '950 SAR/mo',
        'installments': '950 ر.س / شهر',
        'isTamaraAvailable': true,
      },
      {
        'name': 'Hyundai Accent 2024',
        'image': AppImages.assetsImagesYaris,
        'cashPrice': '68,500 SAR',
        'installmentPrice': '990 SAR/mo',
        'installments': '990 ر.س / شهر',
        'isTamaraAvailable': false,
      },
    ],
    // index 1: 1000-1500 SAR installment
    [
      {
        'name': 'Toyota Camry 2024',
        'image': AppImages.assetsImagesCamry,
        'cashPrice': '115,000 SAR',
        'installmentPrice': '1,450 SAR/mo',
        'installments': '1,450 ر.س / شهر',
        'isTamaraAvailable': true,
      },
      {
        'name': 'Nissan Altima 2024',
        'image': AppImages.assetsImagesCamry,
        'cashPrice': '110,000 SAR',
        'installmentPrice': '1,380 SAR/mo',
        'installments': '1,380 ر.س / شهر',
        'isTamaraAvailable': true,
      },
    ],
    // index 2: 1500-2000 SAR installment
    [
      {
        'name': 'Mazda CX-5 2024',
        'image': AppImages.assetsImagesCamry,
        'cashPrice': '145,000 SAR',
        'installmentPrice': '1,850 SAR/mo',
        'installments': '1,850 ر.س / شهر',
        'isTamaraAvailable': false,
      },
      {
        'name': 'Honda CR-V 2024',
        'image': AppImages.assetsImagesCamry,
        'cashPrice': '155,000 SAR',
        'installmentPrice': '1,950 SAR/mo',
        'installments': '1,950 ر.س / شهر',
        'isTamaraAvailable': true,
      },
    ],
    // index 3: Over 2000 SAR installment
    [
      {
        'name': 'Mercedes G-Class 2024',
        'image': AppImages.assetsImagesGclass,
        'cashPrice': '850,000 SAR',
        'installmentPrice': '12,500 SAR/mo',
        'installments': '12,500 ر.س / شهر',
        'isTamaraAvailable': false,
      },
      {
        'name': 'Ferrari SF90 Stradale',
        'image': AppImages.assetsImagesFerrari,
        'cashPrice': '1,800,000 SAR',
        'installmentPrice': '24,500 SAR/mo',
        'installments': '24,500 ر.س / شهر',
        'isTamaraAvailable': false,
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
          return HorizontalCarCardWidget(
            car: cars[index],
            heroTag: 'budget_car_image_${cars[index]['itemCode'] ?? cars[index]['name']}',
          );
        },
      ),
    );
  }
}
