import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CarQuotationPdfGenerator {
  // ─── Arabic number-to-words (فصحى) ───────────────────────────
  static String _convertGroup(int n) {
    const onesWords = [
      '', 'واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة',
      'ستة', 'سبعة', 'ثمانية', 'تسعة', 'عشرة',
      'أحد عشر', 'اثنا عشر', 'ثلاثة عشر', 'أربعة عشر', 'خمسة عشر',
      'ستة عشر', 'سبعة عشر', 'ثمانية عشر', 'تسعة عشر',
    ];
    const tensWords = [
      '', 'عشرة', 'عشرون', 'ثلاثون', 'أربعون', 'خمسون',
      'ستون', 'سبعون', 'ثمانون', 'تسعون',
    ];
    const hundredsWords = [
      '', 'مائة', 'مائتان', 'ثلاثمائة', 'أربعمائة', 'خمسمائة',
      'ستمائة', 'سبعمائة', 'ثمانمائة', 'تسعمائة',
    ];

    if (n == 0) return '';
    if (n < 20) return onesWords[n];
    if (n < 100) {
      final int t = n ~/ 10;
      final int o = n % 10;
      if (o == 0) return tensWords[t];
      return '${onesWords[o]} و${tensWords[t]}';
    }
    final int h = n ~/ 100;
    final int rem = n % 100;
    if (rem == 0) return hundredsWords[h];
    return '${hundredsWords[h]} و${_convertGroup(rem)}';
  }

  static String numberToArabicWords(int number) {
    if (number == 0) return 'صفر ريال';

    final List<String> parts = [];

    final int millions = number ~/ 1000000;
    final int thousands = (number % 1000000) ~/ 1000;
    final int remainder = number % 1000;

    // ── Millions ──
    if (millions > 0) {
      if (millions == 1) {
        parts.add('مليون');
      } else if (millions == 2) {
        parts.add('مليونان');
      } else if (millions >= 3 && millions <= 10) {
        parts.add('${_convertGroup(millions)} ملايين');
      } else {
        parts.add('${_convertGroup(millions)} مليون');
      }
    }

    // ── Thousands ──
    if (thousands > 0) {
      if (thousands == 1) {
        parts.add('ألف');
      } else if (thousands == 2) {
        parts.add('ألفان');
      } else if (thousands >= 3 && thousands <= 10) {
        parts.add('${_convertGroup(thousands)} آلاف');
      } else {
        parts.add('${_convertGroup(thousands)} ألف');
      }
    }

    // ── Remainder (ones / tens / hundreds) ──
    if (remainder > 0) {
      parts.add(_convertGroup(remainder));
    }

    return '${parts.join(' و')} ريال';
  }

  // ─── PDF Generation ──────────────────────────────────────────
  static Future<Uint8List> generateQuotationPdf({
    required Map<String, String> car,
  }) async {
    final pdf = pw.Document();

    final fontRegular = await PdfGoogleFonts.cairoRegular();
    final fontBold = await PdfGoogleFonts.cairoBold();

    pw.ImageProvider? logoImage;
    pw.ImageProvider? stampImage;

    try {
      final ByteData logoData = await rootBundle.load('assets/images/loge.png');
      logoImage = pw.MemoryImage(logoData.buffer.asUint8List());
    } catch (e) {}

    try {
      final ByteData stampData =
          await rootBundle.load('assets/images/stamp.png');
      stampImage = pw.MemoryImage(stampData.buffer.asUint8List());
    } catch (e) {}

    // ── Bank name comes from car data ──
    final String bankName = car['bank'] ?? 'مصرف الراجحي';

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                       HEADER                             ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildHeader() {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.red800, width: 1.5),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(15)),
        ),
        padding:
            const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Logo on the left with red circle border
            logoImage != null
                ? pw.Container(
                    width: 70,
                    height: 70,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      border:
                          pw.Border.all(color: PdfColors.red800, width: 2),
                    ),
                    child: pw.ClipOval(
                      child: pw.Image(logoImage, width: 65, height: 65,
                          fit: pw.BoxFit.contain),
                    ),
                  )
                : pw.Container(width: 70, height: 70),
            // Company info
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'شركة هاجد بن وزير وأولاده للتجارة',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      font: fontBold,
                      fontSize: 18,
                      color: PdfColors.grey700),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'HAJID BIN WAZIR AL-MUTAIRI AND SONS TRADING',
                  style: pw.TextStyle(
                      font: fontBold,
                      fontSize: 13,
                      color: PdfColors.red800),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      '* سجل تجاري : 1010179293',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontBold, fontSize: 10),
                    ),
                    pw.SizedBox(width: 30),
                    pw.Text(
                      '* سجل ضريبي : 300021909200003',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontBold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                  TITLE & SALUTATION                      ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildTitleAndSalutation() {
      final now = DateTime.now();
      final dateStr = '${now.year}/${now.month}/${now.day}';

      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.SizedBox(height: 5),
          // Date on the RIGHT
          pw.Text(
            'التاريخ : $dateStr',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(font: fontBold, fontSize: 11),
          ),
          pw.SizedBox(height: 5),
          pw.Center(
            child: pw.Text(
              'عرض أسعار للبنوك',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 14,
                decoration: pw.TextDecoration.underline,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'السادة / $bankName',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(font: fontBold, fontSize: 12),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            'المحترمين',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(font: fontBold, fontSize: 12),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'تحية طيبة وبعد ،،،،،،',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(font: fontBold, fontSize: 12),
          ),
          pw.SizedBox(height: 10),
        ],
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                        TABLE                             ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildTable() {
      final priceStr = car['price']?.replaceAll(',', '') ?? '0';
      final double price = double.tryParse(priceStr) ?? 0;
      final double vat = price * 0.15;
      final double plates = 1250;
      final double total = price + vat + plates;
      final String carName = car['name'] ??
          'تويوتا لاندكروزر برادو 4 سلندر - دبل لتر تربو، 4-اسطوانات 2.4';
      final String specs = car['specs'] ??
          'قير اتوماتيك - زجاج كهرباء - جنوط - بنزين - تشغيل بصمة - حساسات خلفية - مثبت سرعة - مقاعد مخمل - شاشة معلومات - كاميرا خلفية - 7 راكب - دفع رباعي - ثلاجه';

      return pw.Column(
        children: [
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black, width: 1),
            columnWidths: {
              0: const pw.IntrinsicColumnWidth(),
              1: const pw.IntrinsicColumnWidth(),
              2: const pw.IntrinsicColumnWidth(),
              3: const pw.IntrinsicColumnWidth(),
              4: const pw.IntrinsicColumnWidth(),
              5: const pw.IntrinsicColumnWidth(),
              6: const pw.IntrinsicColumnWidth(),
              7: const pw.FlexColumnWidth(),
              8: const pw.IntrinsicColumnWidth(),
            },
            children: [
              pw.TableRow(
                decoration:
                    const pw.BoxDecoration(color: PdfColors.red100),
                children: [
                  'إجمالي',
                  'قيمة\nاللوحات',
                  'قيمة مضافة\n15%',
                  'سعر الوحدة',
                  'الهيكل',
                  'الموديل',
                  'اللون',
                  'نوع ومواصفات السيارة',
                  'م',
                ].map((text) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 8, horizontal: 4),
                    child: pw.Text(
                      text,
                      textDirection: pw.TextDirection.rtl,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  );
                }).toList(),
              ),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      total.toStringAsFixed(0),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      plates.toStringAsFixed(0),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      vat.toStringAsFixed(0),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      price.toStringAsFixed(0),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      car['chassis'] ?? 'JTEAA9AJ9\nTK037212',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      car['year'] ?? '2026',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      car['color'] ?? 'ابيض',
                      textDirection: pw.TextDirection.rtl,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 8, horizontal: 6),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          carName,
                          textDirection: pw.TextDirection.rtl,
                          textAlign: pw.TextAlign.center,
                          style:
                              pw.TextStyle(font: fontBold, fontSize: 11),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'TXL1',
                          textAlign: pw.TextAlign.center,
                          style:
                              pw.TextStyle(font: fontBold, fontSize: 11),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'المواصفات :-',
                          textDirection: pw.TextDirection.rtl,
                          textAlign: pw.TextAlign.right,
                          style:
                              pw.TextStyle(font: fontBold, fontSize: 11),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          specs,
                          textDirection: pw.TextDirection.rtl,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              font: fontRegular, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 12, horizontal: 4),
                    child: pw.Text(
                      '1',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: fontBold, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ── Total in Arabic words (فصحى) ──
          pw.Container(
            width: double.infinity,
            decoration: pw.BoxDecoration(
              color: PdfColors.red100,
              border: pw.Border(
                left:
                    const pw.BorderSide(color: PdfColors.black, width: 1),
                right:
                    const pw.BorderSide(color: PdfColors.black, width: 1),
                bottom:
                    const pw.BorderSide(color: PdfColors.black, width: 1),
              ),
            ),
            padding: const pw.EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            child: pw.Text(
              'الإجمـــــــــــــــالي / ${numberToArabicWords(total.toInt())}',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(font: fontBold, fontSize: 13),
            ),
          ),
        ],
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║              7 CONDITIONS (تفاصيل)                       ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildConditions() {
      final conditions = [
        '1/ العرض ساري لمدة 3 أيام من تاريخ العرض',
        '2/ السعر شامل الضريبة و شامل اللوحات',
        '3/ السيارة مواصفات وضمان عبد اللطيف جميل ( 3 سنوات او 100 الف كيلو)',
        '4/ مكان التسليم : مقر شركتنا',
        '5/ مندوب المبيعات / يوسف هاجد',
        '6/ جوال / 0505668888',
        '7/ السجل الضريبي / 300021909200003',
      ];

      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.SizedBox(height: 15),
          ...conditions.map((c) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text(
                  c,
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(font: fontBold, fontSize: 11),
                ),
              )),
        ],
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                   STAMP & SIGNATURE                      ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildStamp() {
      return pw.Center(
        child: stampImage != null
            ? pw.Image(stampImage, width: 140, height: 140)
            : pw.Container(width: 140, height: 140),
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                       FOOTER                             ║
    // ╚═══════════════════════════════════════════════════════════╝
    pw.Widget buildFooter() {
      return pw.Column(
        children: [
          pw.Divider(color: PdfColors.black, thickness: 2),
          pw.SizedBox(height: 5),
          pw.Text(
            'الرياض - حي القادسية - شارع وادي الرمة - تليفون : 2311114 / 011-2378511 فاكس 011-237551 ص.ب : 91290',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(font: fontBold, fontSize: 10),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            'EMAIL : BN_WAZIR@YAHOO.COM الرمز البريدي : 11633 - عضوية الغرفة التجارية : 105555 - ترخيص مرور : 729',
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
                font: fontBold, fontSize: 10, color: PdfColors.blue800),
          ),
        ],
      );
    }

    // ╔═══════════════════════════════════════════════════════════╗
    // ║                     BUILD PAGE                           ║
    // ╚═══════════════════════════════════════════════════════════╝
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Watermark
              pw.Positioned(
                top: 250,
                left: 100,
                child: pw.Transform.rotate(
                  angle: -0.5,
                  child: pw.Text(
                    'BN WAZIR',
                    style: pw.TextStyle(
                      fontSize: 100,
                      color: PdfColors.grey200,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Column(
                children: [
                  buildHeader(),
                  buildTitleAndSalutation(),
                  buildTable(),
                  pw.Expanded(
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment:
                          pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.only(top: 20),
                            child: buildStamp(),
                          ),
                        ),
                        pw.Expanded(flex: 2, child: buildConditions()),
                      ],
                    ),
                  ),
                  buildFooter(),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
