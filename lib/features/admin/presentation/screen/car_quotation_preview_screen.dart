import 'package:car/core/utils/car_quotation_pdf_generator.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/theme/app_colors.dart';

class CarQuotationPreviewScreen extends StatelessWidget {
  final GetBrandCarsDataModel car;

  const CarQuotationPreviewScreen({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: AppColor.scaffoldColor(context),
        elevation: 0,
        centerTitle: true,
        title: const Text('معاينة العرض'),
      ),
      body: PdfPreview(
        build: (format) => CarQuotationPdfGenerator.generateQuotationPdf(
          car: car,
        ),
        pdfFileName: 'عرض_سعر_${car.itemName}.pdf',
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
      ),
    );
  }
}
