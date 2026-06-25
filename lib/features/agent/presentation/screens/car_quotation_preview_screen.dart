import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/car_quotation_offers_pdf_generator.dart';
import 'package:car/features/agent/data/model/offer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

class CarQuotationOffersPreviewScreen extends StatefulWidget {
  final List<OfferModel> offers;
  final int offerId;

  const CarQuotationOffersPreviewScreen({super.key, required this.offers, required this.offerId});

  @override
  State<CarQuotationOffersPreviewScreen> createState() => _CarQuotationOffersPreviewScreenState();
}

class _CarQuotationOffersPreviewScreenState extends State<CarQuotationOffersPreviewScreen> {
  OfferModel? _selectedOffer;

  @override
  void initState() {
    super.initState();

    // ✅ البحث عن العرض المطلوب من القائمة المرسلة
    try {
      _selectedOffer = widget.offers.firstWhere((offer) => offer.listNo == widget.offerId);
    } catch (e) {
      _selectedOffer = null;
    }

    // ✅ جلب أحدث البيانات من الـ API (اختياري)
    final represNo = int.tryParse(HiveMethods.getUserCode() ?? '1') ?? 1;
    context.read<AgentCubit>().getOffers(null, represNo, widget.offerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: AppColor.scaffoldColor(context),
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocaleKey.quotation_preview.tr()),
      ),
      body: BlocListener<AgentCubit, AgentState>(
        listener: (context, state) {
          // ✅ عند استلام البيانات من الـ API، تحديث العرض
          if (state.offersStatus.isSuccess) {
            final offers = state.offersStatus.data ?? [];
            final updatedOffer = offers.firstWhere(
              (offer) => offer.listNo == widget.offerId,
              orElse: () => _selectedOffer!,
            );

            setState(() {
              _selectedOffer = updatedOffer;
            });
          }
        },
        child: _selectedOffer == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red),
                    SizedBox(height: 16),
                    Text('العرض غير موجود'),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('رجوع')),
                  ],
                ),
              )
            : PdfPreview(
                build: (format) => CarQuotationOffersGenerator.generateOffersQuotationPdf(
                  offer: _selectedOffer!, // ✅ العرض المحدد
                  bankName: _selectedOffer!.customerName,
                ),
                pdfFileName:
                    '${AppLocaleKey.quotation_file_name.tr()}_${_selectedOffer!.customerName}.pdf',
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
              ),
      ),
    );
  }
}
