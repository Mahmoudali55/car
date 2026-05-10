import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FqaItemWidget extends StatefulWidget {
  const FqaItemWidget({super.key, required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  State<FqaItemWidget> createState() => _FqaItemWidgetState();
}

class _FqaItemWidgetState extends State<FqaItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColor.secondAppColor(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _isExpanded 
                  ? AppColor.primaryColor(context).withOpacity(0.3) 
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withOpacity(0.8),
                        fontSize: 14.sp,
                        fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.remove_rounded : Icons.add_rounded,
                    color: _isExpanded 
                        ? AppColor.primaryColor(context) 
                        : AppColor.blackTextColor(context).withOpacity(0.24),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                Gap(12.h),
                Text(
                  widget.answer,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withOpacity(0.6),
                    fontSize: 12.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
