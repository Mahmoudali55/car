import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/creat_offer_model.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_quote_header_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/customer_dropdown_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/info_chip_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/payment_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/sar_field_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_title_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/sections_title_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/submit_footer_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/total_banner_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuoteBuilderDialog extends StatefulWidget {
  final GetBrandCarsDataModel car;
  final Map<String, String> existingSpecs;

  const QuoteBuilderDialog({super.key, required this.car, required this.existingSpecs});

  static void show(
    BuildContext context, {
    required GetBrandCarsDataModel car,
    required Map<String, String> existingSpecs,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<AgentCubit>(),
        child: QuoteBuilderDialog(car: car, existingSpecs: existingSpecs),
      ),
    );
  }

  @override
  State<QuoteBuilderDialog> createState() => _QuoteBuilderDialogState();
}

class _QuoteBuilderDialogState extends State<QuoteBuilderDialog> {
  // ── Controllers ──────────────────────────────────────────────
  late TextEditingController _priceController;
  final TextEditingController _taxController = TextEditingController(text: '15');
  final TextEditingController _platePriceController = TextEditingController(text: '600');

  final TextEditingController _specController = TextEditingController();
  final TextEditingController _customerSearchController = TextEditingController();

  // ── State ─────────────────────────────────────────────────────
  final List<String> _instantSpecs = [];
  CustomerModel? _selectedCustomer;
  String _paymentType = 'CSH'; // CSH = نقد, CRD = آجل
  bool _isCustomerDropdownOpen = false;

  // ── Derived ──────────────────────────────────────────────────
  int get _represNo {
    final code = HiveMethods.getUserCode() ?? '1';
    return int.tryParse(code) ?? 1;
  }

  num get _price => num.tryParse(_priceController.text) ?? 0;
  num get _taxRate => 0.15;
  num get _platePrice => num.tryParse(_platePriceController.text) ?? 0;

  num get _taxAmount => _price * _taxRate;
  num get _total => (_price + _taxAmount + _platePrice) * 1;

  String get _today => DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get _lastDate =>
      DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 8)));

  /// TERMS = المواصفات الإضافية التي أضافها المستخدم
  String get _terms => _instantSpecs.join(' | ');

  /// NOTE = المواصفات الموجودة للسيارة (existingSpecs + carSpecification)
  String get _carNote {
    final List<String> parts = _existingSpecsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (widget.car.carSpecification != null && widget.car.carSpecification!.trim().isNotEmpty) {
      parts.add(widget.car.carSpecification!.trim());
    }
    return parts.join(' | ');
  }

  late Map<String, String> _editableSpecs;
  final TextEditingController _newSpecKeyController = TextEditingController();
  final TextEditingController _newSpecValueController = TextEditingController();
  late TextEditingController _existingSpecsController;
  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.car.price ?? '0');
    // Trigger customer list load
    context.read<AgentCubit>().getCustomer(null);
    // حوّل الـ map إلى نص
    final initialText = widget.existingSpecs.entries
        .where((e) => e.value.trim().isNotEmpty && e.value.trim() != '—' && e.value.trim() != '-')
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
    _existingSpecsController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _priceController.dispose();

    _platePriceController.dispose();
    _existingSpecsController.dispose();
    _specController.dispose();
    _customerSearchController.dispose();
    super.dispose();
  }

  void _addSpec() {
    if (_specController.text.trim().isNotEmpty) {
      setState(() {
        _instantSpecs.add(_specController.text.trim());
        _specController.clear();
      });
    }
  }

  void _removeSpec(int index) {
    setState(() => _instantSpecs.removeAt(index));
  }

  void _submit(BuildContext context) {
    if (_selectedCustomer == null) {
      _showError(
        context,
        context.locale.languageCode == 'ar'
            ? 'برجاء اختيار العميل أولاً'
            : 'Please select a customer first',
      );
      return;
    }

    final subList = [
      OfferItemModel(
        itemCode: widget.car.itemCode,
        itemName: widget.car.itemName,
        colorCode: widget.car.colorCode,
        chassisNo: widget.car.chassisNo,
        makeYear: widget.car.makeYear,
        qnty: 1,
        price: _price,
        note: _carNote,
        taxVal: _taxAmount,
        paintingsVal: _platePrice,
      ),
    ];

    final offer = CreatOfferModel(
      listDate: _today,
      taamedDate: _today,
      lastDate: _lastDate,
      customerNo: _selectedCustomer!.customerNo ?? 0,
      represCode: _represNo,
      resType: 1,
      paymentType: _paymentType,
      guarPrimary: 0,
      guarFinal: 0,
      deliveryPeriod: 0,
      listPeriod: 1,
      notes: null,
      terms: _terms.isEmpty ? null : _terms,
      total: _total,
      subList: subList,
    );

    context.read<AgentCubit>().addbookingpermission(offer);
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColor.redColor(context),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';

    return BlocListener<AgentCubit, AgentState>(
      listenWhen: (p, c) => p.createOfferStatus != c.createOfferStatus,
      listener: (context, state) {
        if (state.createOfferStatus.isSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.createOfferStatus.message ??
                    (isAr ? 'تمت العملية بنجاح' : 'Operation successful'),
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColor.greenColor(context),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              margin: EdgeInsets.all(16.w),
            ),
          );
          context.read<AgentCubit>().resetCreateOfferStatus();
        } else if (state.createOfferStatus.isFailure) {
          _showError(
            context,
            state.createOfferStatus.error ?? (isAr ? 'حدث خطأ' : 'An error occurred'),
          );
          context.read<AgentCubit>().resetCreateOfferStatus();
        }
      },
      child: SingleChildScrollView(
        child: FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: Container(
            height: 0.92.sh,
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColor.blackColor(context).withValues(alpha: 0.1),
                  blurRadius: 40,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                CustomQuoteHeaderWidget(widget: widget),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Date ─────────────────────────────────────────
                        SectionTitle(
                          title: AppLocaleKey.date.tr(),
                          icon: Icons.calendar_today_rounded,
                        ),
                        Gap(10.h),
                        InfoChip(
                          icon: Icons.event_rounded,
                          label: _today,
                          color: AppColor.primaryColor(context),
                          context: context,
                        ),
                        Gap(20.h),

                        // ── Customer ──────────────────────────────────────
                        SectionTitle(
                          title: AppLocaleKey.customer.tr(),
                          icon: Icons.person_search_rounded,
                        ),
                        Gap(10.h),
                        CustomerDropdown(
                          selected: _selectedCustomer,
                          isOpen: _isCustomerDropdownOpen,
                          searchController: _customerSearchController,
                          onToggle: () =>
                              setState(() => _isCustomerDropdownOpen = !_isCustomerDropdownOpen),
                          onSelect: (c) => setState(() {
                            _selectedCustomer = c;
                            _isCustomerDropdownOpen = false;
                            _customerSearchController.clear();
                            context.read<AgentCubit>().getCustomer(null);
                          }),
                          onSearch: (v) =>
                              context.read<AgentCubit>().getCustomer(v.isEmpty ? null : v),
                          context: context,
                        ),
                        Gap(20.h),

                        // ── Payment Type ──────────────────────────────────
                        SectionTitle(
                          title: AppLocaleKey.payment_type.tr(),
                          icon: Icons.payments_rounded,
                        ),
                        Gap(10.h),
                        PaymentToggle(
                          value: _paymentType,

                          onChanged: (v) => setState(() => _paymentType = v),
                          context: context,
                        ),
                        Gap(20.h),

                        // ── Price ─────────────────────────────────────────
                        SectionTitle(
                          title: AppLocaleKey.agentSellingPrice.tr(),
                          icon: Icons.sell_rounded,
                        ),
                        Gap(10.h),
                        SarField(
                          controller: _priceController,
                          context: context,
                          onChanged: (_) => setState(() {}),
                        ),
                        Gap(16.h),

                        // ── Tax ───────────────────────────────────────────

                        // حقل النسبة + شريط عرض القيمة المحسوبة
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(8.h),
                            // شريط القيمة المحسوبة
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: AppColor.orangeColor(context).withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColor.orangeColor(context).withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calculate_outlined,
                                        size: 16.sp,
                                        color: AppColor.orangeColor(context),
                                      ),
                                      Gap(8.w),
                                      Text(
                                        AppLocaleKey.tax.tr(),
                                        style: AppTextStyle.bodySmall(context).copyWith(
                                          color: AppColor.orangeColor(context),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${NumberFormat('#,##0.##').format(_taxAmount)} ${AppLocaleKey.sar.tr()}',
                                    style: AppTextStyle.bodyMedium(context).copyWith(
                                      color: AppColor.orangeColor(context),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(16.h),
                        // ── Plate Price ───────────────────────────────────
                        SectionTitle(
                          title: AppLocaleKey.agentPlatePrice.tr(),
                          icon: Icons.credit_card_rounded,
                        ),
                        Gap(10.h),
                        SarField(
                          controller: _platePriceController,
                          context: context,
                          onChanged: (_) => setState(() {}),
                        ),
                        Gap(16.h),
                        TotalBanner(
                          price: _price,
                          taxAmount: _taxAmount,
                          platePrice: _platePrice,
                          total: _total,
                          context: context,
                        ),
                        Gap(20.h),
                        SectionTitleWidget(
                          title: AppLocaleKey.specs.tr(),
                          icon: Icons.add_task_rounded,
                        ),
                        Gap(10.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomFormField(
                                controller: _specController,
                                hintText: AppLocaleKey.enterSpecTitle.tr(),
                                onSubmitted: (_) => _addSpec(),
                                validator: (v) => null,
                              ),
                            ),
                            Gap(12.w),
                            GestureDetector(
                              onTap: _addSpec,
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor(context),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: AppColor.whiteColor(context),
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_instantSpecs.isNotEmpty) ...[
                          Gap(14.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: _instantSpecs.asMap().entries.map((entry) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor(context).withValues(alpha: 0.07),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColor.primaryColor(context).withValues(alpha: 0.15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      entry.value,
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        color: AppColor.primaryColor(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Gap(8.w),
                                    GestureDetector(
                                      onTap: () => _removeSpec(entry.key),
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        size: 16.sp,
                                        color: AppColor.primaryColor(context),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        Gap(20.h),

                        // ── Existing Specs ────────────────────────────────
                        SectionTitleWidget(
                          title: AppLocaleKey.existingSpecs.tr(),
                          icon: Icons.list_alt_rounded,
                        ),
                        Gap(10.h),
                        CustomFormField(
                          controller: _existingSpecsController,
                          hintText: AppLocaleKey.enter_spec_title_hint.tr(),
                          maxLines: 6,
                          validator: (_) => null,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Footer Submit ─────────────────────────────────────────
                SubmitFooter(onSubmit: () => _submit(context), context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
