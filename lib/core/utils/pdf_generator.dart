import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class QuotePdfGenerator {
  static Future<void> generateCarQuotation(Map<String, dynamic> car, BuildContext context) async {
    final pdf = pw.Document();

    // Load Arabic font
    final arabicFont = await PdfGoogleFonts.cairoRegular();
    final arabicFontBold = await PdfGoogleFonts.cairoBold();

    // Load logo image
    final ByteData logoData = await rootBundle.load('assets/images/loge.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final logoImage = pw.MemoryImage(logoBytes);

    // Car placeholder image if exists / can be handled if it's an asset
    pw.ImageProvider? carImageProvider;
    try {
      if (car['image'] != null && car['image'].toString().startsWith('assets/')) {
        final ByteData carData = await rootBundle.load(car['image']);
        carImageProvider = pw.MemoryImage(carData.buffer.asUint8List());
      }
    } catch (e) {
      // Ignored if car image loading fails
    }

    final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final textCompany = AppLocaleKey.carApp.tr();
    final textDate = "${AppLocaleKey.appointmentDate.tr()}: $dateStr";
    final textHeader = AppLocaleKey.carQuotation.tr();
    final brandModel = AppLocaleKey.brandAndModel.tr();
    final manufacturingYear = AppLocaleKey.manufacturingYear.tr();
    final engine = AppLocaleKey.engine.tr();
    final priceStr = car['price'] ?? "N/A";
    final textTotalPrice = "${AppLocaleKey.price.tr()}: $priceStr";
    final refNo = "${AppLocaleKey.referenceNumber.tr()}: HBW-${car['name'].hashCode.abs().toString().substring(0, 4)}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicFontBold),
        textDirection: context.locale.languageCode == 'ar'
            ? pw.TextDirection.rtl
            : pw.TextDirection.ltr,
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // HEADER
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        textCompany,
                        style: pw.TextStyle(
                          font: arabicFontBold,
                          fontSize: 26,
                          color: PdfColors.blue900,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        textDate,
                        style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                      ),
                      pw.Text(
                        refNo,
                        style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                      ),
                    ],
                  ),
                  pw.Container(
                    width: 75,
                    height: 75,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      border: pw.Border.all(color: PdfColors.blue900, width: 2),
                      image: pw.DecorationImage(image: logoImage, fit: pw.BoxFit.cover),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 30),

              pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: const pw.BoxDecoration(
                  color: PdfColors.blue900,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Center(
                  child: pw.Text(
                    textHeader.toUpperCase(),
                    style: pw.TextStyle(font: arabicFontBold, fontSize: 24, color: PdfColors.white),
                  ),
                ),
              ),
              pw.SizedBox(height: 40),

              // CAR INFO & IMAGE
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildRowInfo(brandModel, car['name'] ?? '', arabicFontBold),
                        pw.SizedBox(height: 10),
                        _buildRowInfo(manufacturingYear, car['year'] ?? '', arabicFontBold),
                        pw.SizedBox(height: 10),
                        _buildRowInfo(engine, car['engine'] ?? '', arabicFontBold),
                        pw.SizedBox(height: 10),
                        _buildRowInfo(
                          AppLocaleKey.mileageKm.tr(),
                          car['mileage'] ?? '',
                          arabicFontBold,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  if (carImageProvider != null)
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        height: 120,
                        decoration: pw.BoxDecoration(
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                          border: pw.Border.all(color: PdfColors.grey300),
                          image: pw.DecorationImage(
                            image: carImageProvider,
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              pw.SizedBox(height: 40),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 20),

              // PRICE
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    AppLocaleKey.quoteValidity.tr(),
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                  ),
                  pw.Text(
                    textTotalPrice,
                    style: pw.TextStyle(
                      font: arabicFontBold,
                      fontSize: 22,
                      color: PdfColors.green800,
                    ),
                  ),
                ],
              ),

              pw.Spacer(),

              // FOOTER
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  AppLocaleKey.thankYouQuote.tr(),
                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Quotation_${car['name'] ?? 'Car'}.pdf',
    );
  }

  static pw.Row _buildRowInfo(String label, String value, pw.Font boldFont) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "$label: ",
          style: pw.TextStyle(font: boldFont, fontSize: 16, color: PdfColors.grey800),
        ),
        pw.Expanded(child: pw.Text(value, style: const pw.TextStyle(fontSize: 16))),
      ],
    );
  }
}
