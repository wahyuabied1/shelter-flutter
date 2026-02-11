import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/design/app_colors.dart';

// ── Pipeline Step Status ──
enum _StepStatus { completed, active, upcoming }

class DetailIssueScreen extends StatefulWidget {
  const DetailIssueScreen({super.key});

  @override
  State<DetailIssueScreen> createState() => _DetailIssueScreenState();
}

class _DetailIssueScreenState extends State<DetailIssueScreen> {
  // Dummy data — ganti dengan data dari API
  final _ticketNumber = 'ISS-2026-01-986';
  final _priority = 'Urgent';
  final _issueType = 'Client';
  final _author = 'Ahmad Fauzi';
  final _createdAt = '2025-01-05 08:30:15';
  final _currentStep = 2; // 0=Register, 1=Response, 2=On Progress, 3=Closed
  final _slaPercent = 100;
  final _slaStatus = 'On Time';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Issue',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _ticketNumber,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryIssue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon:
                const Icon(Icons.account_circle_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTicketHeader(),
            const SizedBox(height: 16),
            _buildPipelineTracking(),
            const SizedBox(height: 16),
            _buildSlaStatus(),
            const SizedBox(height: 16),
            _buildDetailIssue(),
            const SizedBox(height: 16),
            _buildDeskripsiIssue(),
            const SizedBox(height: 16),
            _buildLampiran(),
            const SizedBox(height: 16),
            _buildAssignedPic(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════
  //  Ticket Header
  // ══════════════════════════════════════
  Widget _buildTicketHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryIssue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.confirmation_number_rounded,
              color: AppColors.primaryIssue,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _ticketNumber,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildBadge(_priority, AppColors.error, AppColors.errorBg),
                    const SizedBox(width: 6),
                    _buildBadge(_issueType, AppColors.primaryIssue,
                        AppColors.primaryIssue.withOpacity(0.08)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Dibuat oleh $_author  •  $_createdAt',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          _buildPopupMenu(),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded, color: AppColors.textMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      onSelected: (value) {
        // TODO: Handle menu actions
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined,
                  size: 18, color: AppColors.textSecondary),
              SizedBox(width: 10),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'request_close',
          child: Row(
            children: [
              Icon(Icons.send_rounded, size: 18, color: AppColors.error),
              SizedBox(width: 10),
              Text('Request Close', style: TextStyle(color: AppColors.error)),
            ],
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════
  //  Pipeline Tracking
  // ══════════════════════════════════════
  Widget _buildPipelineTracking() {
    final steps = [
      const _PipelineStep(
          'Register', '08:30', Icons.assignment_rounded, Color(0xFF29B6F6)),
      const _PipelineStep('Response', '08:30', Icons.access_time_filled_rounded,
          Color(0xFF7C3AED)),
      const _PipelineStep(
          'On Progress', '08:30', Icons.bolt_rounded, Color(0xFFFF7043)),
      const _PipelineStep(
          'Closed', '08:30', Icons.check_circle_rounded, Color(0xFFBDBDBD)),
    ];

    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          const Row(
            children: [
              Icon(Icons.timeline_rounded,
                  size: 18, color: AppColors.primaryIssue),
              SizedBox(width: 8),
              Text(
                'Pipeline Tracking',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Stepper ──
          _buildStepperRow(steps),
        ],
      ),
    );
  }

  Widget _buildStepperRow(List<_PipelineStep> steps) {
    return Column(
      children: [
        // ── BARIS 1: Icon boxes + connector lines ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            // ODD → connector line
            if (index.isOdd) {
              final leftStepIndex = index ~/ 2;
              final isCompleted = leftStepIndex < _currentStep;

              return Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? const LinearGradient(
                            colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
                          )
                        : null,
                    color: isCompleted ? null : const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }

            // EVEN → icon box
            final stepIndex = index ~/ 2;
            final step = steps[stepIndex];
            final _StepStatus status = stepIndex < _currentStep
                ? _StepStatus.completed
                : stepIndex == _currentStep
                    ? _StepStatus.active
                    : _StepStatus.upcoming;

            return _buildStepIconBox(step, status);
          }),
        ),

        const SizedBox(height: 12),

        // ── BARIS 2: Labels + waktu + check icon ──
        Row(
          children: List.generate(steps.length, (stepIndex) {
            final step = steps[stepIndex];
            final _StepStatus status = stepIndex < _currentStep
                ? _StepStatus.completed
                : stepIndex == _currentStep
                    ? _StepStatus.active
                    : _StepStatus.upcoming;

            final Color labelColor = status == _StepStatus.upcoming
                ? AppColors.textMuted
                : AppColors.textPrimary;

            return Expanded(
              child: Column(
                children: [
                  Text(
                    step.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: labelColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.time,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    status == _StepStatus.upcoming
                        ? Icons.radio_button_unchecked_rounded
                        : Icons.check_circle_rounded,
                    size: 18,
                    color: status == _StepStatus.upcoming
                        ? const Color(0xFFBDBDBD)
                        : AppColors.success,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

// ──────────────────────────────────────
//  Icon box: rounded rectangle dengan warna unik per step
// ──────────────────────────────────────
  Widget _buildStepIconBox(_PipelineStep step, _StepStatus status) {
    final Color boxColor =
        status == _StepStatus.upcoming ? const Color(0xFFEEEEEE) : step.color;

    final Color iconColor =
        status == _StepStatus.upcoming ? const Color(0xFFBDBDBD) : Colors.white;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: status != _StepStatus.upcoming
            ? [
                BoxShadow(
                  color: boxColor.withOpacity(0.40),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Icon(step.icon, size: 26, color: iconColor),
    );
  }

  // ══════════════════════════════════════
  //  SLA Status
  // ══════════════════════════════════════
  Widget _buildSlaStatus() {
    final isOnTime = _slaStatus == 'On Time';
    final statusColor = isOnTime ? AppColors.success : AppColors.error;
    final bgColor = isOnTime ? AppColors.successBg : AppColors.errorBg;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.trending_up_rounded, size: 24, color: statusColor),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'SLA Status: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
                children: [
                  TextSpan(
                    text: _slaStatus,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '$_slaPercent %',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  //  Detail Issue
  // ══════════════════════════════════════
  Widget _buildDetailIssue() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.list_alt_rounded,
                  size: 18, color: AppColors.primaryIssue),
              SizedBox(width: 8),
              Text(
                'Detail Issue',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDetailField('Labour', 'Labour')),
              const SizedBox(width: 12),
              Expanded(child: _buildDetailField('Branch', 'Jakarta Selatan')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDetailField('Site', 'PT Prima Boga 1')),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildDetailField('Jenis Keluhan', 'Sistem Error')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _buildDetailField(
                      'Tanggal Dibuat', '2025-01-05 08:30:15')),
              const SizedBox(width: 12),
              Expanded(child: _buildDetailField('Durasi', '374 hari 0 jam')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceLighter,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════
  //  Deskripsi Issue
  // ══════════════════════════════════════
  Widget _buildDeskripsiIssue() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_rounded,
                  size: 18, color: AppColors.primaryIssue),
              SizedBox(width: 8),
              Text(
                'Deskripsi Issue',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLighter,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Text(
              'Sistem absensi mengalami error sejak pagi hari. '
              'Karyawan tidak dapat melakukan check-in/check-out. '
              'Issue ini sangat mendesak karena mempengaruhi '
              'operasional harian di site. Mohon segera dilakukan '
              'penanganan dan perbaikan sistem.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  //  Lampiran
  // ══════════════════════════════════════
  Widget _buildLampiran() {
    final attachments = [
      const _Attachment(
        name: 'screenshot-error-absensi.png',
        size: '2.4 MB',
        uploader: 'Ahmad Fauzi',
        date: '2025-01-05 08:35:00',
      ),
      const _Attachment(
        name: 'log-error-system.pdf',
        size: '1.1 MB',
        uploader: 'Ahmad Fauzi',
        date: '2025-01-05 08:36:00',
      ),
    ];

    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_file_rounded,
                  size: 18, color: AppColors.primaryIssue),
              const SizedBox(width: 8),
              Text(
                'Lampiran (${attachments.length})',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...attachments.map((file) => _buildAttachmentItem(file)),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(_Attachment file) {
    final isPdf = file.name.endsWith('.pdf');
    final iconColor = isPdf ? AppColors.error : AppColors.primaryIssue;
    final iconBg =
        isPdf ? AppColors.errorBg : AppColors.primaryIssue.withOpacity(0.08);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLighter,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${file.size}  •  ${file.uploader}  •  ${file.date}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded,
                size: 20, color: AppColors.primaryIssue),
            onPressed: () {
              // TODO: Download file
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  //  Assigned PIC
  // ══════════════════════════════════════
  Widget _buildAssignedPic() {
    final pics = [
      const _PicData(
        name: 'Ahmad Fauzi',
        email: 'ahmad.fauzi@shelter.com',
        role: 'Account Manager',
      ),
      const _PicData(
        name: 'Rudi Hermawan',
        email: 'rudi.hermawan@shelter.com',
        role: 'Technical Support',
      ),
    ];

    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.groups_rounded,
                  size: 18, color: AppColors.primaryIssue),
              SizedBox(width: 8),
              Text(
                'Assigned PIC',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...pics.map((pic) => _buildPicItem(pic)),
        ],
      ),
    );
  }

  Widget _buildPicItem(_PicData pic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLighter,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryIssue.withOpacity(0.1),
            child: Text(
              pic.name.isNotEmpty ? pic.name[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryIssue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pic.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  pic.email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.badge_outlined,
                        size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      pic.role,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════
  //  Shared Card
  // ══════════════════════════════════════
  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Data Classes ──

class _PipelineStep {
  final String label;
  final String time;
  final IconData icon;
  final Color color;

  const _PipelineStep(this.label, this.time, this.icon, this.color);
}

class _Attachment {
  final String name;
  final String size;
  final String uploader;
  final String date;

  const _Attachment({
    required this.name,
    required this.size,
    required this.uploader,
    required this.date,
  });
}

class _PicData {
  final String name;
  final String email;
  final String role;

  const _PicData({
    required this.name,
    required this.email,
    required this.role,
  });
}
