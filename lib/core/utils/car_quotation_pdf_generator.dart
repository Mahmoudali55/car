import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ═══════════════════════════════════════════════════════════════
//  CONSTANTS
// ═══════════════════════════════════════════════════════════════
class _C {
  // Font sizes
  static const double fsTitle = 15.0;
  static const double fsEnTitle = 10.0;
  static const double fsRegInfo = 8.5;
  static const double fsDateBank = 10.0;
  static const double fsTableHeader = 9.5;
  static const double fsTableBody = 9.5;
  static const double fsSpecs = 8.5;
  static const double fsTotal = 11.0;
  static const double fsCondition = 9.5;
  static const double fsFooter = 8.5;

  // Spacing
  static const double spXS = 2.0;
  static const double spSM = 4.0;
  static const double spMD = 6.0;
  static const double spLG = 8.0;

  // Padding
  static const pw.EdgeInsets padCell = pw.EdgeInsets.symmetric(vertical: 5, horizontal: 3);
  static const pw.EdgeInsets padSpecsCell = pw.EdgeInsets.symmetric(vertical: 6, horizontal: 5);

  // Colors
  static const PdfColor headerBg = PdfColors.red50;
  static const PdfColor totalBg = PdfColors.red50;
  static const PdfColor borderColor = PdfColors.black;
  static const PdfColor accentRed = PdfColors.red800;
  static const PdfColor watermark = PdfColors.blue50;
  static const PdfColor greyText = PdfColors.grey700;
}

// ═══════════════════════════════════════════════════════════════
//  HELPERS
// ═══════════════════════════════════════════════════════════════
class _H {
  static String arabicDigits(String input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String r = input;
    for (int i = 0; i < en.length; i++) r = r.replaceAll(en[i], ar[i]);
    return r;
  }

  static String _group(int n) {
    const ones = [
      '',
      'واحد',
      'اثنان',
      'ثلاثة',
      'أربعة',
      'خمسة',
      'ستة',
      'سبعة',
      'ثمانية',
      'تسعة',
      'عشرة',
      'أحد عشر',
      'اثنا عشر',
      'ثلاثة عشر',
      'أربعة عشر',
      'خمسة عشر',
      'ستة عشر',
      'سبعة عشر',
      'ثمانية عشر',
      'تسعة عشر',
    ];
    const tens = [
      '',
      'عشرة',
      'عشرون',
      'ثلاثون',
      'أربعون',
      'خمسون',
      'ستون',
      'سبعون',
      'ثمانون',
      'تسعون',
    ];
    const hundreds = [
      '',
      'مائة',
      'مائتان',
      'ثلاثمائة',
      'أربعمائة',
      'خمسمائة',
      'ستمائة',
      'سبعمائة',
      'ثمانمائة',
      'تسعمائة',
    ];
    if (n == 0) return '';
    if (n < 20) return ones[n];
    if (n < 100) {
      final t = n ~/ 10, o = n % 10;
      return o == 0 ? tens[t] : '${ones[o]} و${tens[t]}';
    }
    final h = n ~/ 100, rem = n % 100;
    return rem == 0 ? hundreds[h] : '${hundreds[h]} و${_group(rem)}';
  }

  static String numberToWords(int n) {
    if (n == 0) return 'صفر ريال';
    final parts = <String>[];
    final m = n ~/ 1000000, th = (n % 1000000) ~/ 1000, rem = n % 1000;
    if (m > 0)
      parts.add(
        m == 1
            ? 'مليون'
            : m == 2
            ? 'مليونان'
            : m <= 10
            ? '${_group(m)} ملايين'
            : '${_group(m)} مليون',
      );
    if (th > 0)
      parts.add(
        th == 1
            ? 'ألف'
            : th == 2
            ? 'ألفان'
            : th <= 10
            ? '${_group(th)} آلاف'
            : '${_group(th)} ألف',
      );
    if (rem > 0) parts.add(_group(rem));
    return '${parts.join(' و')} ريال';
  }

  static String todayStr() {
    final now = DateTime.now();
    return arabicDigits(
      '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}',
    );
  }

  // Convenient text builder
  static pw.Text txt(
    String text,
    pw.Font font, {
    double size = 10,
    PdfColor color = PdfColors.black,
    pw.TextAlign align = pw.TextAlign.right,
    pw.TextDecoration? decoration,
    bool rtl = true,
  }) => pw.Text(
    text,
    textDirection: rtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
    textAlign: align,
    style: pw.TextStyle(font: font, fontSize: size, color: color, decoration: decoration),
  );
}

// ═══════════════════════════════════════════════════════════════
//  WIDGET BUILDERS  (all static, receive fonts/images as args)
// ═══════════════════════════════════════════════════════════════

// ── 1. Header ─────────────────────────────────────────────────
pw.Widget _buildHeader({required pw.Font bold, pw.ImageProvider? logo}) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.blueGrey700, width: 1.2),
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
    ),
    padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        logo != null
            ? pw.Container(width: 60, height: 60, child: pw.Image(logo, fit: pw.BoxFit.contain))
            : pw.SizedBox(width: 60, height: 60),

        // Company info
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            _H.txt('شركة هاجد بن وزير وأولاده للتجارة', bold, size: _C.fsTitle, color: _C.greyText),
            pw.SizedBox(height: _C.spXS),
            _H.txt(
              'HAJID BIN WAZIR AL-MUTAIRI AND SONS TRADING',
              bold,
              size: _C.fsEnTitle,
              color: _C.accentRed,
              rtl: false,
              align: pw.TextAlign.center,
            ),
            pw.SizedBox(height: _C.spSM),
            pw.Row(
              children: [
                _H.txt(
                  '* سجل تجارى   : ${_H.arabicDigits("1010179293")}',
                  bold,
                  size: _C.fsRegInfo,
                ),
                pw.SizedBox(width: 20),
                _H.txt(
                  '* سجل ضريبي : ${_H.arabicDigits("300021909200003")}',
                  bold,
                  size: _C.fsRegInfo,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// ── 2. Title & Salutation ─────────────────────────────────────
pw.Widget _buildTitleAndSalutation({required pw.Font bold, required String bankName}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      pw.SizedBox(height: _C.spSM),
      _H.txt('التاريخ : ${_H.todayStr()}', bold, size: _C.fsDateBank, align: pw.TextAlign.right),
      pw.SizedBox(height: _C.spSM),
      pw.Center(
        child: _H.txt(
          'عرض أسعار للبنوك',
          bold,
          size: _C.fsDateBank + 1,
          align: pw.TextAlign.center,
          decoration: pw.TextDecoration.underline,
        ),
      ),
      pw.SizedBox(height: _C.spMD),
      _H.txt('السادة / $bankName', bold, size: _C.fsDateBank, align: pw.TextAlign.right),
      pw.SizedBox(height: _C.spXS),
      _H.txt('المحترمين', bold, size: _C.fsDateBank, align: pw.TextAlign.center),
      pw.SizedBox(height: _C.spXS),
      _H.txt('تحية طيبة وبعد ،،،،،،', bold, size: _C.fsDateBank, align: pw.TextAlign.center),
      pw.SizedBox(height: _C.spMD),
    ],
  );
}

// ── 3. Table header cell ───────────────────────────────────────
pw.Widget _headerCell(String text, pw.Font bold) => pw.Container(
  padding: const pw.EdgeInsets.symmetric(vertical: 7, horizontal: 4),
  width: double.infinity,
  child: _H.txt(text, bold, size: _C.fsTableHeader, align: pw.TextAlign.center),
);

// ── 4. Table body cell ────────────────────────────────────────
pw.Widget _bodyCell(String text, pw.Font font, {bool rtl = false}) => pw.Container(
  width: double.infinity, // ← يمتد
  padding: _C.padCell,
  child: _H.txt(text, font, size: _C.fsTableBody, align: pw.TextAlign.center, rtl: rtl),
);

// ── 5. Specs cell (largest column) ────────────────────────────
pw.Widget _specsCell({
  required String carName,
  required String trim,
  required String specs,
  required pw.Font bold,
  required pw.Font regular,
}) => pw.Padding(
  padding: _C.padSpecsCell,
  child: pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      _H.txt(carName, bold, size: _C.fsTableBody, align: pw.TextAlign.center),
      pw.SizedBox(height: _C.spXS),
      _H.txt(trim, bold, size: _C.fsTableBody, align: pw.TextAlign.center, rtl: false),
      pw.SizedBox(height: _C.spXS),
      _H.txt('المواصفات :-', bold, size: _C.fsSpecs, align: pw.TextAlign.right),
      pw.SizedBox(height: _C.spXS),
      _H.txt(specs, regular, size: _C.fsSpecs, align: pw.TextAlign.right),
    ],
  ),
);

// ── 6. Full table ─────────────────────────────────────────────
pw.Widget _buildTable({
  required GetBrandCarsDataModel car,
  required pw.Font bold,
  required pw.Font regular,
}) {
  final price = double.tryParse(car.price?.replaceAll(',', '') ?? '0') ?? 0;
  final vat = price * 0.15;
  const plates = 1250.0;
  final total = price + vat + plates;

  final carName = car.itemName;
  final specs = car.carSpecification ?? '—';

  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(color: _C.borderColor, width: 0.8),
        columnWidths: const {
          0: pw.FlexColumnWidth(1.2), // إجمالي
          1: pw.FlexColumnWidth(1.0), // لوحات
          2: pw.FlexColumnWidth(1.2), // ضريبة
          3: pw.FlexColumnWidth(1.2), // سعر
          4: pw.FlexColumnWidth(1.5), // هيكل
          5: pw.FlexColumnWidth(0.9), // موديل
          6: pw.FlexColumnWidth(0.9), // لون
          7: pw.FlexColumnWidth(4.0), // مواصفات
          8: pw.FlexColumnWidth(0.5), // م
        },
        children: [
          // ── Header row ──
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: _C.headerBg), // ← هنا اللون
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
            ].map((t) => _headerCell(t, bold)).toList(),
          ),
          // ── Data row ──
          pw.TableRow(
            children: [
              _bodyCell(total.toStringAsFixed(0), bold),
              _bodyCell(plates.toStringAsFixed(0), bold),
              _bodyCell(vat.toStringAsFixed(0), bold),
              _bodyCell(price.toStringAsFixed(0), bold),
              _bodyCell(car.chassisNo, bold),
              _bodyCell(car.makeYear.toString(), bold),
              _bodyCell(car.bodyColor, bold, rtl: true),
              _specsCell(
                carName: carName,
                trim: '',
                specs: specs,
                bold: bold,
                regular: regular,
              ),
              _bodyCell('1', bold),
            ],
          ),
        ],
      ),
      // ── Total bar ──
      pw.Container(
        width: double.infinity,
        decoration: pw.BoxDecoration(
          color: _C.totalBg,
          border: pw.Border(
            left: const pw.BorderSide(color: _C.borderColor, width: 0.8),
            right: const pw.BorderSide(color: _C.borderColor, width: 0.8),
            bottom: const pw.BorderSide(color: _C.borderColor, width: 0.8),
          ),
        ),
        padding: const pw.EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: _H.txt(
          'الإجمـــــالي / ${_H.numberToWords(total.toInt())}',
          bold,
          size: _C.fsTotal,
          align: pw.TextAlign.center,
        ),
      ),
    ],
  );
}

// ── 7. Conditions ─────────────────────────────────────────────
pw.Widget _buildConditions({required pw.Font bold}) {
  final items = [
    _H.arabicDigits('1/ العرض ساري لمدة 3 أيام من تاريخ العرض'),
    _H.arabicDigits('2/ السعر شامل الضريبة و شامل اللوحات'),
    _H.arabicDigits('3/ السيارة مواصفات وضمان عبد اللطيف جميل ( 3 سنوات او 100 الف كيلو)'),
    _H.arabicDigits('4/ مكان التسليم : مقر شركتنا'),
    _H.arabicDigits('5/ مندوب المبيعات / يوسف هاجد'),
    _H.arabicDigits('6/ جوال / 0505568888'),
    _H.arabicDigits('7/ السجل الضريبي / 300021909200003'),
  ];

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: items
        .map(
          (c) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: _C.spSM),
            child: _H.txt(c, bold, size: _C.fsCondition),
          ),
        )
        .toList(),
  );
}

// ── 8. Stamp ──────────────────────────────────────────────────
pw.Widget _buildStamp({pw.ImageProvider? stamp}) => pw.Center(
  child: stamp != null ? pw.Image(stamp, width: 110) : pw.SizedBox(width: 110, height: 110),
);

// ── 9. Footer ─────────────────────────────────────────────────
pw.Widget _buildFooter({required pw.Font bold}) => pw.Column(
  children: [
    pw.Divider(color: _C.borderColor, thickness: 1.5),
    pw.SizedBox(height: _C.spXS),
    _H.txt(
      _H.arabicDigits(
        'الرياض - حي القادسية - شارع وادي الرمة - تليفون : 2311114 / 011-2378511 فاكس 2337551-011 ص.ب : 91290',
      ),
      bold,
      size: _C.fsFooter,
      align: pw.TextAlign.center,
    ),
    pw.SizedBox(height: _C.spXS),
    pw.RichText(
      textDirection: pw.TextDirection.rtl,
      textAlign: pw.TextAlign.center,
      text: pw.TextSpan(
        style: pw.TextStyle(font: bold, fontSize: _C.fsFooter),
        children: [
          pw.TextSpan(text: _H.arabicDigits('الرمز البريدى: 11633 ')),
          pw.TextSpan(
            text: ' EMAIL : BN_WAZIR@YAHOO.COM ',
            style: pw.TextStyle(color: PdfColors.blue800, decoration: pw.TextDecoration.underline),
          ),
          pw.TextSpan(text: _H.arabicDigits(' عضوية الغرفة التجارية : 105555 - ترخيص مرور : 729')),
        ],
      ),
    ),
  ],
);

// ── 10. Watermark ─────────────────────────────────────────────
pw.Widget _buildWatermark() => pw.Positioned(
  top: 300,
  left: 40,
  child: pw.Transform.rotate(
    angle: 0.8,
    child: pw.Text(
      'BNWAZIR',
      style: pw.TextStyle(fontSize: 120, color: _C.watermark, fontWeight: pw.FontWeight.bold),
    ),
  ),
);

// ═══════════════════════════════════════════════════════════════
//  MAIN GENERATOR
// ═══════════════════════════════════════════════════════════════
class CarQuotationPdfGenerator {
  // Public helpers (kept for backward compat)
  static String toArabicDigits(String input) => _H.arabicDigits(input);
  static String numberToArabicWords(int number) => _H.numberToWords(number);

  static Future<Uint8List> generateQuotationPdf({required GetBrandCarsDataModel car}) async {
    final pdf = pw.Document();
    final fontRegular = await PdfGoogleFonts.cairoRegular();
    final fontBold = await PdfGoogleFonts.cairoBold();

    pw.ImageProvider? logoImage;
    pw.ImageProvider? stampImage;

    try {
      final data = await rootBundle.load('assets/images/loge3.png');
      logoImage = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {}

    try {
      final data = await rootBundle.load('assets/images/stamp2.png');
      stampImage = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {}

    final bankName = car.storeCode.isNotEmpty ? car.storeCode : 'مصرف الراجحي';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // ── Background watermark ──
              _buildWatermark(),

              // ── Main content ──
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildHeader(bold: fontBold, logo: logoImage),
                  pw.SizedBox(height: _C.spXS),
                  _buildTitleAndSalutation(bold: fontBold, bankName: bankName),
                  _buildTable(car: car, bold: fontBold, regular: fontRegular),
                  pw.SizedBox(height: _C.spMD),

                  // ── Conditions + Stamp side by side ──
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Expanded(flex: 2, child: _buildConditions(bold: fontBold)),
                        pw.Expanded(child: _buildStamp(stamp: stampImage)),
                      ],
                    ),
                  ),

                  _buildFooter(bold: fontBold),
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
