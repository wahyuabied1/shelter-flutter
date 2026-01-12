import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/design/empty_list_widget.dart';
import 'package:shelter_super_app/feature/hadirqu/home/paid_leave/time_off_viewmodel.dart';
import 'package:shelter_super_app/feature/hadirqu/home/widget/time_off_card.dart';

import '../../../../design/loading_list_shimmer.dart';

class SickLeaveSection extends StatelessWidget {
  const SickLeaveSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeOffViewmodel>(
      create: (context) => TimeOffViewmodel()..getSickLeave(),
      child: _SickLeaveSectionView(),
    );
  }
}

class _SickLeaveSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TimeOffViewmodel>();
    final data = vm.sickLeaveOff.dataOrNull;
    if (vm.sickLeaveOff.isInitialOrLoading) return const LoadingListShimmer(count: 2);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal:16.w,vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data?.isEmpty ?? false)
            const EmptyListWidget(
              title: "Belum Ada Pengajuan",
              subtitle:
              "Belum ada yang mengajukan cuti sakit untuk hari ini.",
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
                  .map((item) => TimeOffCard(timeOffResponse: item, title:"Sakit"))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
