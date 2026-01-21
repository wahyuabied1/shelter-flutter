import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/report_dashboard_viewmodel.dart';
import 'widget/employee_detail_card.dart';

class EmployeePresentDetailScreen extends StatelessWidget {
  final bool isPresent; // true = hadir, false = tidak hadir

  const EmployeePresentDetailScreen({
    super.key,
    this.isPresent = true,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ReportDashboardViewmodel>(),
      child: EmployeePresentDetailCard(isPresent: isPresent),
    );
  }
}
