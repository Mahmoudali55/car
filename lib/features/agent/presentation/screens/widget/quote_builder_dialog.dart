import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/creat_offer_model.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_quote_header_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_title_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      _SectionTitle(
                        title: isAr ? 'تاريخ الحركة' : 'Transaction Date',
                        icon: Icons.calendar_today_rounded,
                      ),
                      Gap(10.h),
                      _InfoChip(
                        icon: Icons.event_rounded,
                        label: _today,
                        color: AppColor.primaryColor(context),
                        context: context,
                      ),
                      Gap(20.h),

                      // ── Customer ──────────────────────────────────────
                      _SectionTitle(
                        title: isAr ? 'العميل' : 'Customer',
                        icon: Icons.person_search_rounded,
                      ),
                      Gap(10.h),
                      _CustomerDropdown(
                        isAr: isAr,
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
                      _SectionTitle(
                        title: isAr ? 'نوع الدفع' : 'Payment Type',
                        icon: Icons.payments_rounded,
                      ),
                      Gap(10.h),
                      _PaymentToggle(
                        value: _paymentType,
                        isAr: isAr,
                        onChanged: (v) => setState(() => _paymentType = v),
                        context: context,
                      ),
                      Gap(20.h),

                      // ── Price ─────────────────────────────────────────
                      _SectionTitle(
                        title: isAr ? 'سعر البيع' : 'Selling Price',
                        icon: Icons.sell_rounded,
                      ),
                      Gap(10.h),
                      _SarField(
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
                                      isAr ? 'قيمة الضريبة' : 'Tax Amount',
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        color: AppColor.orangeColor(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${NumberFormat('#,##0.##').format(_taxAmount)} ${isAr ? "ريال" : "SAR"}',
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
                      _SectionTitle(
                        title: isAr ? 'قيمة اللوحات' : 'Plate Price',
                        icon: Icons.credit_card_rounded,
                      ),
                      Gap(10.h),
                      _SarField(
                        controller: _platePriceController,
                        context: context,
                        onChanged: (_) => setState(() {}),
                      ),
                      Gap(16.h),

                      // ── Quantity ──────────────────────────────────────

                      // ── Total (computed) ──────────────────────────────
                      _TotalBanner(
                        price: _price,
                        taxAmount: _taxAmount,
                        platePrice: _platePrice,
                        total: _total,
                        isAr: isAr,
                        context: context,
                      ),
                      Gap(20.h),

                      // ── Additional Specs ──────────────────────────────
                      SectionTitleWidget(
                        title: isAr ? 'مواصفات العرض' : 'Additional Specs',
                        icon: Icons.add_task_rounded,
                      ),
                      Gap(10.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormField(
                              controller: _specController,
                              hintText: isAr ? 'أدخل مواصفة...' : 'Enter spec...',
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
                              child: Icon(Icons.add_rounded, color: Colors.white, size: 28.sp),
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
                        title: isAr ? 'المواصفات الموجودة' : 'Existing Specs',
                        icon: Icons.list_alt_rounded,
                      ),
                      Gap(10.h),
                      CustomFormField(
                        controller: _existingSpecsController,
                        hintText: isAr
                            ? 'أدخل المواصفات، كل مواصفة في سطر...'
                            : 'Enter specs, one per line...',
                        maxLines: 6,
                        validator: (_) => null,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Footer Submit ─────────────────────────────────────────
              _SubmitFooter(isAr: isAr, onSubmit: () => _submit(context), context: context),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable Sub-widgets ──────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColor.primaryColor(context)),
        Gap(8.w),
        Text(
          title,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w800, color: AppColor.blackTextColor(context)),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final BuildContext context;
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: color),
          Gap(8.w),
          Text(
            label,
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PaymentToggle extends StatelessWidget {
  final String value;
  final bool isAr;
  final ValueChanged<String> onChanged;
  final BuildContext context;
  const _PaymentToggle({
    required this.value,
    required this.isAr,
    required this.onChanged,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        _PaymentOption(
          label: isAr ? 'نقد' : 'Cash',
          icon: Icons.payments_rounded,
          code: 'CSH',
          selected: value == 'CSH',
          onTap: () => onChanged('CSH'),
          context: context,
        ),
        Gap(12.w),
        _PaymentOption(
          label: isAr ? 'آجل' : 'Credit',
          icon: Icons.schedule_rounded,
          code: 'CRD',
          selected: value == 'CRD',
          onTap: () => onChanged('CRD'),
          context: context,
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final String code;
  final bool selected;
  final VoidCallback onTap;
  final BuildContext context;
  const _PaymentOption({
    required this.label,
    required this.icon,
    required this.code,
    required this.selected,
    required this.onTap,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: selected ? primary : primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? primary : primary.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: selected ? Colors.white : primary),
              Gap(8.w),
              Text(
                label,
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: selected ? Colors.white : primary, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SarField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;
  final ValueChanged<String>? onChanged;
  const _SarField({required this.controller, required this.context, this.onChanged});

  @override
  Widget build(BuildContext ctx) {
    return CustomFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      hintText: '0',
      onChanged: onChanged,
      suffixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: SvgPicture.asset(
          AppImages.sar,
          height: 20.h,
          colorFilter: ColorFilter.mode(AppColor.primaryColor(context), BlendMode.srcIn),
        ),
      ),
      validator: (v) => null,
    );
  }
}

class _TotalBanner extends StatelessWidget {
  final num price;
  final num taxAmount;
  final num platePrice;
  final num total;
  final bool isAr;
  final BuildContext context;

  const _TotalBanner({
    required this.price,
    required this.taxAmount,
    required this.platePrice,
    required this.total,
    required this.isAr,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary.withValues(alpha: 0.12), primary.withValues(alpha: 0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          // تفاصيل البنود
          _TotalRow(
            label: isAr ? 'سعر البيع' : 'Price',
            value: price,
            isAr: isAr,
            context: context,
            color: AppColor.blackTextColor(context),
          ),
          Gap(6.h),
          _TotalRow(
            label: isAr ? 'الضريبة' : 'Tax',
            value: taxAmount,
            isAr: isAr,
            context: context,
            color: AppColor.orangeColor(context),
          ),
          Gap(6.h),
          _TotalRow(
            label: isAr ? 'اللوحات' : 'Plates',
            value: platePrice,
            isAr: isAr,
            context: context,
            color: AppColor.greyColor(context),
          ),
          Gap(10.h),
          Divider(color: primary.withValues(alpha: 0.2), height: 1),
          Gap(10.h),
          // الإجمالي الكلي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calculate_rounded, color: primary, size: 20.sp),
                  Gap(8.w),
                  Text(
                    isAr ? 'الإجمالي' : 'Total',
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: primary, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(
                '${NumberFormat('#,##0.##').format(total)} ${isAr ? "ريال" : "SAR"}',
                style: AppTextStyle.titleLarge(
                  context,
                ).copyWith(color: primary, fontWeight: FontWeight.w900, fontSize: 22.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Row مساعد داخل البانر
class _TotalRow extends StatelessWidget {
  final String label;
  final num value;
  final bool isAr;
  final BuildContext context;
  final Color color;

  const _TotalRow({
    required this.label,
    required this.value,
    required this.isAr,
    required this.context,
    required this.color,
  });

  @override
  Widget build(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.w600),
        ),
        Text(
          '${NumberFormat('#,##0.##').format(value)} ${isAr ? "ريال" : "SAR"}',
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _CustomerDropdown extends StatelessWidget {
  final bool isAr;
  final CustomerModel? selected;
  final bool isOpen;
  final TextEditingController searchController;
  final VoidCallback onToggle;
  final ValueChanged<CustomerModel> onSelect;
  final ValueChanged<String> onSearch;
  final BuildContext context;

  const _CustomerDropdown({
    required this.isAr,
    required this.selected,
    required this.isOpen,
    required this.searchController,
    required this.onToggle,
    required this.onSelect,
    required this.onSearch,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isOpen ? primary : AppColor.borderColor(context).withValues(alpha: 0.3),
                width: isOpen ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 18.sp,
                  color: selected != null ? primary : AppColor.hintColor(context),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    selected?.customerName ?? (isAr ? 'اختر العميل...' : 'Select customer...'),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: selected != null
                          ? AppColor.blackTextColor(context)
                          : AppColor.hintColor(context),
                      fontWeight: selected != null ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.hintColor(context),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),

        // Dropdown panel
        if (isOpen)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(top: 6.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: primary.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: AppColor.blackColor(context).withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search inside dropdown
                CustomFormField(
                  controller: searchController,
                  hintText: isAr ? 'بحث بالاسم...' : 'Search by name...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 18.sp,
                    color: AppColor.hintColor(context),
                  ),
                  onChanged: onSearch,
                  validator: (v) => null,
                ),
                Gap(10.h),
                // List of customers
                BlocBuilder<AgentCubit, AgentState>(
                  buildWhen: (p, c) => p.customersStatus != c.customersStatus,
                  builder: (context, state) {
                    if (state.customersStatus.isLoading) {
                      return Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(primary),
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    final customers = state.customersStatus.data ?? [];
                    if (customers.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: Text(
                            isAr ? 'لا يوجد عملاء' : 'No customers found',
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: AppColor.hintColor(context)),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: customers.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: AppColor.borderColor(context).withValues(alpha: 0.15),
                        ),
                        itemBuilder: (context, i) {
                          final c = customers[i];
                          final isSelected = c.customerNo == selected?.customerNo;
                          return GestureDetector(
                            onTap: () => onSelect(c),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primary.withValues(alpha: 0.08)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle_rounded
                                        : Icons.person_outline_rounded,
                                    size: 18.sp,
                                    color: isSelected ? primary : AppColor.hintColor(context),
                                  ),
                                  Gap(10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.customerName ?? '',
                                          style: AppTextStyle.bodySmall(context).copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isSelected
                                                ? primary
                                                : AppColor.blackTextColor(context),
                                          ),
                                        ),
                                        if (c.tel1 != null && c.tel1!.isNotEmpty)
                                          Text(
                                            c.tel1!,
                                            style: AppTextStyle.bodySmall(context).copyWith(
                                              color: AppColor.greyColor(context),
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SubmitFooter extends StatelessWidget {
  final bool isAr;
  final VoidCallback onSubmit;
  final BuildContext context;
  const _SubmitFooter({required this.isAr, required this.onSubmit, required this.context});

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<AgentCubit, AgentState>(
      buildWhen: (p, c) => p.createOfferStatus != c.createOfferStatus,
      builder: (context, state) {
        final isLoading = state.createOfferStatus.isLoading;
        final primary = AppColor.primaryColor(context);

        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            border: Border(
              top: BorderSide(color: AppColor.borderColor(context).withValues(alpha: 0.12)),
            ),
          ),
          child: GestureDetector(
            onTap: isLoading ? null : onSubmit,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 54.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isLoading
                      ? [primary.withValues(alpha: 0.4), primary.withValues(alpha: 0.4)]
                      : [primary, primary.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: isLoading
                    ? []
                    : [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                          Gap(10.w),
                          Text(
                            isAr ? 'انشاء عرض السعر' : 'Submit Quote',
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
