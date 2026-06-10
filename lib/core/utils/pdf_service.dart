import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<pw.Document> generateDocument({
    required BuildContext context,
    required Map<String, dynamic> car,
  }) async {
    final pdf = pw.Document();
    final bool isArabic = el.EasyLocalization.of(context)!.locale.languageCode == 'ar';
    final pw.TextDirection textDirection = isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr;
    final arabicFont = await PdfGoogleFonts.notoKufiArabicBold();
    final regularFont = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();
    final pw.Font baseFont = isArabic ? arabicFont : regularFont;
    final pw.Font boldFace = isArabic ? arabicFont : boldFont;
    // Fetch car image
    pw.ImageProvider? carImage;
    if (car['image'] != null || car['carimage'] != null) {
      final imgUrl = car['image'] ?? car['carimage'];
      try {
        if (imgUrl.toString().startsWith('http')) {
          final response = await http.get(Uri.parse(imgUrl));
          if (response.statusCode == 200) {
            carImage = pw.MemoryImage(response.bodyBytes);
          }
        } else {
          final bytes = await rootBundle.load(imgUrl);
          carImage = pw.MemoryImage(bytes.buffer.asUint8List());
        }
      } catch (e) {
        debugPrint('Error loading image for PDF: $e');
      }
    }
    // Load Logo
    pw.ImageProvider? logoImage;
    try {
      final logoBytes = await rootBundle.load(AppImages.assetsImagesLoge);
      logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());
    } catch (e) {
      debugPrint('Error loading logo for PDF: $e');
    }
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: baseFont, bold: boldFace),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context pdfContext) {
          return [
            pw.Directionality(
              textDirection: textDirection,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // ── HEADER ──
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      if (logoImage != null)
                        pw.Container(width: 80, height: 80, child: pw.Image(logoImage)),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            el.tr(AppLocaleKey.carApp),
                            style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900,
                            ),
                          ),
                          pw.Text(
                            'www.hbwinternational.com',
                            style: pw.TextStyle(fontSize: 10, color: PdfColors.blue700),
                          ),
                          pw.Text(
                            el.DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
                            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Divider(thickness: 1.5, color: PdfColors.blue900),
                  pw.SizedBox(height: 20),
                  // ── CAR TITLE ──
                  pw.Text(
                    '${car['name'] ?? car['ITEM_NAME'] ?? 'Vehicle Report'}',
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.blue900,
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Text(
                          '${car['price'] ?? car['PRICE'] ?? '0'} SAR',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                        el.tr(AppLocaleKey.taxIncluded),
                        style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),

                  // ── MAIN IMAGE ──
                  if (carImage != null)
                    pw.ClipRRect(
                      horizontalRadius: 12,
                      verticalRadius: 12,
                      child: pw.Container(
                        height: 280,
                        width: double.infinity,
                        child: pw.Image(carImage, fit: pw.BoxFit.cover),
                      ),
                    ),
                  pw.SizedBox(height: 30),

                  // ── INSTANT SPECS (Quotes only) ──
                  if (car['instantSpecs'] != null && (car['instantSpecs'] as List).isNotEmpty) ...[
                    _buildSectionTitle(el.tr(AppLocaleKey.instantSpecs)),
                    pw.SizedBox(height: 10),
                    pw.Bullet(
                      text: (car['instantSpecs'] as List).join('\n'),
                      style: pw.TextStyle(fontSize: 12, height: 1.5),
                    ),
                    pw.SizedBox(height: 30),
                  ],

                  // ── SPECIFICATIONS ──
                  _buildSectionTitle(el.tr(AppLocaleKey.basicFeatures)),
                  pw.SizedBox(height: 15),
                  pw.GridView(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    children: [
                      _buildSpecBox(
                        el.tr(AppLocaleKey.modelYear),
                        '${car['year'] ?? car['MAKE_YEAR'] ?? '-'}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.mileage),
                        '${car['mileage'] ?? car['KILOMETER_READING'] ?? '0'} ${el.tr(AppLocaleKey.km)}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.transmission),
                        car['TRANSMISSION'] == 1
                            ? el.tr(AppLocaleKey.agentAutomatic)
                            : el.tr(AppLocaleKey.agentManual),
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.exteriorColor),
                        '${car['Color'] ?? car['BODY_COLOR'] ?? '-'}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.capacity),
                        '${car['SEAT_NO'] ?? '-'} ${el.tr(AppLocaleKey.agentCars)}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.agentSedans),
                        '${car['CYLINDER'] ?? '-'} ${el.tr(AppLocaleKey.agentSedan)}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.agentHatchbacks),
                        '${car['POWER_HOURSE'] ?? '-'} ${el.tr(AppLocaleKey.agentHatchback)}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.agentFuelCapacity),
                        '${car['FUEL_CAPACITY'] ?? '-'} ${el.tr(AppLocaleKey.agentSuv)}',
                      ),
                      _buildSpecBox(
                        el.tr(AppLocaleKey.agentCarNumber),
                        '${car['chassisNo'] ?? car['CHASSIS_NO'] ?? '-'}',
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                  // ── DESCRIPTION ──
                  _buildSectionTitle(el.tr(AppLocaleKey.generalView)),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border.all(color: PdfColors.grey300),
                    ),
                    child: pw.Text(
                      el.tr(AppLocaleKey.specialView),
                      style: pw.TextStyle(fontSize: 12, height: 1.5),
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  // ── FOOTER ──
                  pw.Divider(color: PdfColors.grey400),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Hajed bin Wazir Motors © 2024',
                        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                      ),
                      pw.Text(
                        'info@hbwinternational.com',
                        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
    return pdf;
  }

  static pw.Widget _buildSectionTitle(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.blue900, width: 2)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
      ),
    );
  }

  static pw.Widget _buildSpecBox(String label, String value) {
    return pw.Container(
      margin: const pw.EdgeInsets.all(5),
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey200),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
          pw.SizedBox(height: 2),
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
