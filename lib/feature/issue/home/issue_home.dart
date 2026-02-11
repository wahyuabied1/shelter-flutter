import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/design/app_colors.dart';

import '../../routes/issuequ_routes.dart';

enum _Priority { urgent, high, medium, low }

extension _PriorityStyle on _Priority {
  String get label {
    switch (this) {
      case _Priority.urgent:
        return 'Urgent';
      case _Priority.high:
        return 'High';
      case _Priority.medium:
        return 'Medium';
      case _Priority.low:
        return 'Low';
    }
  }

  Color get color {
    switch (this) {
      case _Priority.urgent:
        return AppColors.error;
      case _Priority.high:
        return AppColors.warning;
      case _Priority.medium:
        return const Color(0xFF3B82F6);
      case _Priority.low:
        return AppColors.success;
    }
  }

  Color get bgColor {
    switch (this) {
      case _Priority.urgent:
        return AppColors.errorBg;
      case _Priority.high:
        return AppColors.warningBg;
      case _Priority.medium:
        return const Color(0xFFDBEAFE);
      case _Priority.low:
        return AppColors.successBg;
    }
  }
}

class IssueHome extends StatefulWidget {
  const IssueHome({super.key});

  @override
  State<IssueHome> createState() => _IssueHomeState();
}

class _IssueHomeState extends State<IssueHome> {
  int _selectedTab = 0;
  final _searchController = TextEditingController();

  final List<String> _tabs = ['Register', 'Respons', 'Progress', 'Closed'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Dashboard Issue',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryIssue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCreateIssueCard(),
            const SizedBox(height: 20),
            _buildOverviewSection(),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildIssueGrid(),
          ],
        ),
      ),
    );
  }

  // ── Create NEW Issue Card ──
  Widget _buildCreateIssueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryIssue, AppColors.gradientIssue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryIssue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.support_agent_rounded,
              size: 100,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bug_report_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Create NEW Issue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Report a new problem to the technical\nsupport team.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(IssueQuRoutes.newIssue.name!);
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'New Ticket',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryIssue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Overview Section ──
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatBox('5', 'Total\nIssue', isHighlighted: true),
              const SizedBox(width: 8),
              _buildStatBox('3', 'Register'),
              const SizedBox(width: 8),
              _buildStatBox('2', 'Respons'),
              const SizedBox(width: 8),
              _buildStatBox('1', 'Progress'),
              const SizedBox(width: 8),
              _buildStatBox('4', 'Closed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String count, String label,
      {bool isHighlighted = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: isHighlighted ? AppColors.primaryIssue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              isHighlighted ? null : Border.all(color: AppColors.borderLight),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: AppColors.primaryIssue.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: isHighlighted
                    ? Colors.white.withOpacity(0.85)
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Tab Bar ──
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primaryIssue,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.primaryIssue : Colors.white,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Search Bar ──
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search.....',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryIssue),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            // TODO: Show filter
          },
          child: const Icon(
            Icons.tune,
            size: 28,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ── Issue Grid ──
  Widget _buildIssueGrid() {
    // Dummy data — ganti dengan data dari API nanti
    final issues = [
      const _DummyIssue(
        code: 'ISS-2025-01-002',
        title:
            'Request Update Database Karyawanhghjgjgjhgjhgjhgjhgjhgjhghjgjgj',
        priority: _Priority.urgent,
        company: 'PT Prima Top Boga 1',
        department: 'Technical Support',
        assignee: 'Rudi Hermawan',
        date: '1/3/2025',
      ),
      const _DummyIssue(
        code: 'ISS-2025-01-003',
        title: 'Server Down Lantai 2',
        priority: _Priority.high,
        company: 'PT Prima Top Boga 1',
        department: 'IT Infrastructure',
        assignee: 'Budi Santoso',
        date: '2/3/2025',
      ),
      const _DummyIssue(
        code: 'ISS-2025-01-004',
        title: 'Permintaan Akses VPN',
        priority: _Priority.medium,
        company: 'PT Prima Top Boga 1',
        department: 'Network',
        assignee: 'Andi Wijaya',
        date: '3/3/2025',
      ),
      const _DummyIssue(
        code: 'ISS-2025-01-005',
        title: 'Update Software Antivirus',
        priority: _Priority.low,
        company: 'PT Prima Top Boga 1',
        department: 'IT Security',
        assignee: 'Siti Rahayu',
        date: '4/3/2025',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: issues.length,
      itemBuilder: (context, index) => _buildIssueCard(issues[index]),
    );
  }

  Widget _buildIssueCard(_DummyIssue issue) {
    return GestureDetector(
      onTap: () => context.pushNamed(IssueQuRoutes.detailIssue.name!),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              issue.code,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryIssue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              issue.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: issue.priority.bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: issue.priority.color, width: 1),
              ),
              child: Text(
                issue.priority.label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: issue.priority.color,
                ),
              ),
            ),
            const Spacer(),
            _buildInfoRow(Icons.business_rounded, issue.company),
            const SizedBox(height: 3),
            _buildInfoRow(Icons.group_rounded, issue.department),
            const SizedBox(height: 3),
            _buildInfoRow(Icons.person_rounded, issue.assignee),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, color: AppColors.borderLight),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 13, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(
                  issue.date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}

// Dummy data — ganti dengan model dari API nanti
class _DummyIssue {
  final String code;
  final String title;
  final _Priority priority;
  final String company;
  final String department;
  final String assignee;
  final String date;

  const _DummyIssue({
    required this.code,
    required this.title,
    required this.priority,
    required this.company,
    required this.department,
    required this.assignee,
    required this.date,
  });
}
