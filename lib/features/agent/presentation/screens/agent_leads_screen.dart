import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';


import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/lead_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentLeadsScreen extends StatefulWidget {
  const AgentLeadsScreen({super.key});

  @override
  State<AgentLeadsScreen> createState() => _AgentLeadsScreenState();
}

class _AgentLeadsScreenState extends State<AgentLeadsScreen> {
  String _search = '';


  List<AgentLead> _getFiltered(LeadStatus? status) {
    return kAgentLeads.where((l) {
      final matchStatus = status == null || l.status == status;
      final matchSearch = _search.isEmpty ||
          l.customerName.contains(_search) ||
          l.carInterest.contains(_search);
      return matchStatus && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        body: NestedScrollView(
          headerSliverBuilder: (_, _) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: AppColor.appBarColor(context),
              elevation: 0,
              expandedHeight: 160.h,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ── Title ──
                        Row(
                          children: [
                            Text(
                              'العملاء المحتملين',
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontWeight: FontWeight.w900,
                                fontSize: 24.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const Spacer(),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// ── Bottom Area (Search + Tabs) ──
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(130.h),
                child: Column(
                  children: [
                    /// 🔍 Search
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                      child: CustomFormField(
                        hintText: 'ابحث بالاسم',
                        radius: 12.r,
                        prefixIcon: Icon(Icons.search_rounded, size: 20.sp, color: AppColor.hintColor(context)),
                        onChanged: (v) => setState(() => _search = v),
                      ),
                    ),

                    /// ── Tabs ──
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColor.blueColor(context).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: AppColor.blueColor(context),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.blueColor(context).withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: AppColor.hintColor(context),
                          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w900, letterSpacing: -0.2),
                          unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'الكل'),
                            Tab(text: 'جديد'),
                            Tab(text: 'جاري'),
                            Tab(text: 'مغلق'),
                            Tab(text: 'مفقود'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          /// ── List Content ──
          body: TabBarView(
            children: [
              _buildList(_getFiltered(null)),
              _buildList(_getFiltered(LeadStatus.newLead)),
              _buildList(_getFiltered(LeadStatus.inProgress)),
              _buildList(_getFiltered(LeadStatus.closed)),
              _buildList(_getFiltered(LeadStatus.lost)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<AgentLead> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: AppColor.hintColor(context).withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.people_outline_rounded, size: 48.sp, color: AppColor.hintColor(context)),
            ),
            Gap(16.h),
            Text(
              'لا توجد نتائج مطابقة',
              style: TextStyle(color: AppColor.hintColor(context), fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
      itemCount: list.length,
      itemBuilder: (_, i) => LeadCard(lead: list[i]),
    );
  }
}



