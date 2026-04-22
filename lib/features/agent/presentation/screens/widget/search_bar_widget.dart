import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AgentTheme.border),
      ),
      child: CustomFormField(
        onChanged: onChanged,
       hintText: 'ابحث باسم العميل أو السيارة...',
          hintStyle: TextStyle(color: AgentTheme.text3, fontSize: 12.sp),
          prefixIcon:
              Icon(Icons.search_rounded, color: AgentTheme.text3, size: 19.sp),
        
      ),
    );
  }
}