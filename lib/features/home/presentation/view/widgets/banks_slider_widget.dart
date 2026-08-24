import 'dart:async';

import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/banks_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BanksSliderWidget extends StatefulWidget {
  final List<BANKSDATAModel>? banks;

  const BanksSliderWidget({super.key, this.banks});

  @override
  State<BanksSliderWidget> createState() => _BanksSliderWidgetState();
}

class _BanksSliderWidgetState extends State<BanksSliderWidget> {
  late ScrollController _scrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startScrolling();
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScroll + 5,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.banksStatus != current.banksStatus,
      builder: (context, state) {
        final List<BANKSDATAModel> banksList;
        if (widget.banks != null && widget.banks!.isNotEmpty) {
          banksList = widget.banks!;
        } else if (state.banksStatus.isSuccess &&
            state.banksStatus.data != null &&
            state.banksStatus.data!.isNotEmpty) {
          banksList = state.banksStatus.data!;
        } else {
          return const SizedBox.shrink();
        }

        if (banksList.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 40.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final bank = banksList[index % banksList.length];
              final String displayName =
                  (context.locale.languageCode == 'en' ? bank.bankNameEng : bank.bankName) ??
                  bank.bankName ??
                  bank.bankNameEng ??
                  '';

              final String logoText = displayName.isNotEmpty ? displayName[0] : '🏦';

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor(context),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        logoText,
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.whiteColor(context),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    Text(
                      displayName,
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
