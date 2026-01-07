import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/design/empty_list_widget.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/feature/hadirqu/home/paid_leave/time_off_viewmodel.dart';
import 'package:shelter_super_app/feature/hadirqu/home/widget/time_off_card.dart';

class PaidLeaveSection extends StatelessWidget {
  const PaidLeaveSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeOffViewmodel>(
      create: (context) => TimeOffViewmodel()..getPaidLeave(),
      child: _PaidLeaveSectionView(),
    );
  }
}

class _PaidLeaveSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TimeOffViewmodel>();
    final data = vm.timeOffResult.dataOrNull;
    if (vm.timeOffResult.isInitialOrLoading) return const LoadingListShimmer(count: 2);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data?.isEmpty ?? false)
            const EmptyListWidget(
              title: "Belum Ada Pengajuan",
              subtitle:
                  "Belum ada yang mengajukan cuti untuk hari ini.",
            ),
          if (data?.isNotEmpty ?? false)
            const Text(
              'Hari Ini',
              style: TextStyle(fontSize: 12),
            ),
          if (data?.isNotEmpty ?? false) const SizedBox(height: 8),
          if (data?.isNotEmpty ?? false)
            Column(
              children: (data ?? [])
                  .map((item) => TimeOffCard(timeOffResponse: item,title:"Cuti"))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
