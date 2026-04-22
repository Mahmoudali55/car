
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widgt.dart';
import 'package:car/features/agent/presentation/screens/widget/lead_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    backgroundColor: AgentTheme.navy,
    body: NestedScrollView(
      headerSliverBuilder: (_, _) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: AgentTheme.navy2,
          elevation: 0,
          expandedHeight: 150.h,

          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔥 العنوان
                    Row(
                      children: [
                        Text(
                          'العملاء المحتملين',
                          style: TextStyle(
                            color: AgentTheme.text1,
                            fontWeight: FontWeight.w900,
                            fontSize: 22.sp,
                          ),
                        ),
                        const Spacer(),
                        IconBtn(
                          icon: Icons.person_add_rounded,
                          onTap: () {},
                        ),

                      ],
                    ),
                    Gap(15.h),

                    
                   
                  ],
                ),
              ),
            ),
          ),

          /// 🔥 TabBar ثابت
          
          bottom: PreferredSize(
  preferredSize: Size.fromHeight(120.h),
  child: Column(
    children: [
      /// 🔍 Search
      Gap(40.h),
      Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
        child: SearchBar(
          onChanged: (v) => setState(() => _search = v),
        ),
      ),

      /// 🔥 TabBar
      Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: AgentTheme.blue,
              borderRadius: BorderRadius.circular(25.r),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AgentTheme.text3,
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

      /// 🔥 المحتوى
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
            Icon(Icons.people_outline_rounded,
                size: 60.sp, color: AgentTheme.text3),
            Gap(16.h),
            Text('لا توجد نتائج',
                style: TextStyle(color: AgentTheme.text2, fontSize: 16.sp)),
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



