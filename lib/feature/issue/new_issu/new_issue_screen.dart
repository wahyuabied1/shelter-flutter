import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/app_colors.dart';

enum _IssueType { client, internal }

class NewIssueScreen extends StatefulWidget {
  const NewIssueScreen({super.key});

  @override
  State<NewIssueScreen> createState() => _NewIssueScreenState();
}

class _NewIssueScreenState extends State<NewIssueScreen> {
  _IssueType? _selectedType;
  final _titleController = TextEditingController();
  final _siteSearchController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedService;
  String? _selectedComplaintType;
  String? _selectedBranch;
  String? _selectedSite;

  final List<String> _picList = [];
  final List<File> _attachedFiles = [];

  // Dummy options — ganti dengan data dari API
  final _services = ['IT Support', 'HR', 'Finance', 'General'];
  final _complaintTypes = ['Bug', 'Request', 'Enhancement', 'Question'];
  final _branches = ['Jakarta', 'Surabaya', 'Bandung', 'Medan'];
  final _sites = ['Site A', 'Site B', 'Site C'];

  @override
  void dispose() {
    _titleController.dispose();
    _siteSearchController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'New Ticket',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryIssue,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTicketHeader(),
                  const SizedBox(height: 16),
                  _buildIssueTypeSection(),
                  const SizedBox(height: 16),
                  _buildInformasiDasarSection(),
                  const SizedBox(height: 16),
                  _buildPicSection(),
                  const SizedBox(height: 16),
                  _buildFilePendukungSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── Ticket Header ──
  Widget _buildTicketHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   colors: [AppColors.paletIssue, Colors.white],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // ),
        color: const Color(0x2900B7FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.paletIssue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.confirmation_number_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ticket Number',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'ISS-2026-01-986',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Created At',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '2026-01-12 10:09:58',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Issue Type Section ──
  Widget _buildIssueTypeSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Issue Type', Icons.category_rounded,
              isRequired: true),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTypeOption(
                  type: _IssueType.client,
                  icon: Icons.business_rounded,
                  title: 'Client',
                  subtitle: 'Issue from external customer',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTypeOption(
                  type: _IssueType.internal,
                  icon: Icons.groups_rounded,
                  title: 'Internal',
                  subtitle: 'Issue from internal team',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeOption({
    required _IssueType type,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryIssue.withOpacity(0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryIssue : AppColors.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryIssue.withOpacity(0.1)
                    : AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color:
                    isSelected ? AppColors.primaryIssue : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? AppColors.primaryIssue : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Informasi Dasar Section ──
  Widget _buildInformasiDasarSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Informasi Dasar', Icons.info_outline_rounded),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Site',
            controller: _siteSearchController,
            isRequired: true,
            hintText: 'Cari site...',
          ),
          const SizedBox(height: 14),
          _buildTextField(
            label: 'Issue Title',
            controller: _titleController,
            isRequired: true,
            hintText: 'Masukkan judul issue',
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Service',
                  isRequired: true,
                  value: _selectedService,
                  items: _services,
                  onChanged: (v) => setState(() => _selectedService = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Complaint Type',
                  isRequired: true,
                  value: _selectedComplaintType,
                  items: _complaintTypes,
                  onChanged: (v) => setState(() => _selectedComplaintType = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Branch',
                  isRequired: true,
                  value: _selectedBranch,
                  items: _branches,
                  onChanged: (v) => setState(() => _selectedBranch = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Site',
                  isRequired: true,
                  value: _selectedSite,
                  items: _sites,
                  onChanged: (v) => setState(() => _selectedSite = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildTextField(
            label: 'Description',
            controller: _descriptionController,
            hintText: 'Jelaskan issue secara detail...',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  // ── PIC Section ──
  Widget _buildPicSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionTitle(
                  'PIC (Multi Select)', Icons.person_add_alt_1_rounded),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Bisa pilih lebih dari satu',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_picList.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _picList.map((pic) {
                return Chip(
                  label: Text(pic),
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryIssue,
                  ),
                  backgroundColor: AppColors.primaryIssue.withOpacity(0.06),
                  side: BorderSide(
                      color: AppColors.primaryIssue.withOpacity(0.2)),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  deleteIconColor: AppColors.primaryIssue,
                  onDeleted: () {
                    setState(() => _picList.remove(pic));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          GestureDetector(
            onTap: () {
              // TODO: Show PIC picker bottom sheet
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryIssue.withOpacity(0.3),
                ),
                color: AppColors.primaryIssue.withOpacity(0.02),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_add_rounded,
                    size: 28,
                    color: AppColors.primaryIssue.withOpacity(0.5),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Add PIC',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryIssue.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── File Pendukung Section ──
  Widget _buildFilePendukungSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('File Pendukung', Icons.attach_file_rounded),
          const SizedBox(height: 12),
          if (_attachedFiles.isNotEmpty) ...[
            ...List.generate(_attachedFiles.length, (index) {
              final file = _attachedFiles[index];
              final name = file.path.split('/').last;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.insert_drive_file_rounded,
                        size: 20, color: AppColors.primaryIssue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textPrimary),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _attachedFiles.removeAt(index));
                      },
                      child: const Icon(Icons.close_rounded,
                          size: 18, color: AppColors.textMuted),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
          GestureDetector(
            onTap: () {
              // TODO: File picker
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
                color: AppColors.surfaceLighter,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_rounded,
                    size: 32,
                    color: AppColors.primaryIssue.withOpacity(0.4),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Drop file here or click to browse',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Maximum 3 files . PDF, DOC, DOCX, JPG, PNG (Max 10MB each)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: AppColors.primaryIssue, width: 1),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder_open_rounded,
                            size: 16, color: AppColors.primaryIssue),
                        SizedBox(width: 6),
                        Text(
                          'BROWSE FILES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryIssue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Bar ──
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Submit issue
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryIssue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  Reusable Builders
  // ═══════════════════════════════════════════

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

  Widget _buildSectionTitle(String title, IconData icon,
      {bool isRequired = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.primaryIssue),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (isRequired) ...[
          const SizedBox(width: 4),
          const Text('*', style: TextStyle(color: AppColors.error)),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    String? hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            children: isRequired
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 13, color: AppColors.textPlaceholder),
            filled: true,
            fillColor: AppColors.surfaceLighter,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primaryIssue, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            children: isRequired
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLighter,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: const Text(
                'Pilih',
                style:
                    TextStyle(fontSize: 13, color: AppColors.textPlaceholder),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textMuted),
              dropdownColor: Colors.white,
              style:
                  const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
