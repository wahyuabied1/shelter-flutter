import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:intl/intl.dart';
import '../../../data/model/guard_mail_response.dart';
import 'viewmodel/mail_viewmodel.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MailViewmodel()..init(),
      child: const _MailView(),
    );
  }
}

class _MailView extends StatefulWidget {
  const _MailView();

  @override
  State<_MailView> createState() => _MailViewState();
}

class _MailViewState extends State<_MailView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MailViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Surat",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DoubleDateWidget(
              endDate: vm.endDate.ddMMyyyy('/'),
              startDate: vm.startDate.ddMMyyyy('/'),
              onChangeStartDate: (date) {
                final parsed = DateFormat('dd/MM/yyyy').parse(date);

                vm.updateStartDate(parsed);
              },
              onChangeEndDate: (date) {
                final parsed = DateFormat('dd/MM/yyyy').parse(date);

                vm.updateEndDate(parsed);
              },
              theme: ThemeWidget.red,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: Export to Excel
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red.shade700,
                  side: const BorderSide(color: Colors.red, width: 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Export ke Excel',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShiftFilter(vm),
                  const SizedBox(width: 12),
                  _buildPetugasFilter(vm),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: SearchWidget(
                hint: 'Cari Surat',
                onSearch: (search) => vm.updateSearchQuery(search),
                theme: ThemeWidget.red,
              ),
            ),
            if (vm.isLoading)
              const LoadingLineShimmer()
            else
              Text(
                vm.totalDataText,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            const SizedBox(height: 8),
            _buildContent(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftFilter(MailViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableShifts.isEmpty) return;

        final Map<String, bool> shiftChoice = {};
        for (var shift in vm.availableShifts) {
          shiftChoice['Shift $shift'] = vm.selectedShift.contains(shift);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Shift",
              choice: shiftChoice,
              theme: ThemeWidget.red,
            );
          },
        );

        if (result != null) {
          final selectedShifts = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final shiftNumber = int.tryParse(key.split(' ')[1]);
              if (shiftNumber != null) selectedShifts.add(shiftNumber);
            }
          });
          vm.updateShiftFilter(selectedShifts);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedShift.isEmpty
              ? Colors.transparent
              : Colors.red.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: vm.selectedShift.isEmpty ? Colors.grey.shade300 : Colors.red,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedShiftText,
              style: TextStyle(
                color: vm.selectedShift.isNotEmpty
                    ? Colors.red.shade700
                    : Colors.black,
                fontWeight: vm.selectedShift.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedShift.isNotEmpty
                  ? Colors.red.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetugasFilter(MailViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availablePetugas.isEmpty) return;

        final Map<String, bool> petugasChoice = {};
        for (var petugas in vm.availablePetugas) {
          petugasChoice[petugas.nama] =
              vm.selectedPetugasIds.contains(petugas.id);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Petugas",
              choice: petugasChoice,
              theme: ThemeWidget.red,
            );
          },
        );

        if (result != null) {
          final selectedIds = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final petugas = vm.availablePetugas.firstWhere(
                (p) => p.nama == key,
                orElse: () => GuardMailFilterPetugas(id: 0, nama: ''),
              );
              if (petugas.id != 0) selectedIds.add(petugas.id);
            }
          });
          vm.updatePetugasFilter(selectedIds);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedPetugasIds.isEmpty
              ? Colors.transparent
              : Colors.red.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: vm.selectedPetugasIds.isEmpty
                ? Colors.grey.shade300
                : Colors.red,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedPetugasText,
              style: TextStyle(
                color: vm.selectedPetugasIds.isNotEmpty
                    ? Colors.red.shade700
                    : Colors.black,
                fontWeight: vm.selectedPetugasIds.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedPetugasIds.isNotEmpty
                  ? Colors.red.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(MailViewmodel vm) {
    if (vm.isLoading) {
      return const LoadingListShimmer(
        marginHorizontal: false,
      );
    }

    if (vm.isError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => vm.getMail(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (vm.mailList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            vm.searchQuery.isNotEmpty ||
                    vm.selectedShift.isNotEmpty ||
                    vm.selectedPetugasIds.isNotEmpty
                ? 'Tidak ada data yang sesuai filter'
                : 'Tidak ada data',
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vm.mailList.length,
      itemBuilder: (context, index) {
        final item = vm.mailList[index];
        return _card(item);
      },
    );
  }

  Widget _card(dynamic mail) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  mail.petugas.photo != null && mail.petugas.photo!.isNotEmpty
                      ? CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(mail.petugas.photo!),
                        )
                      : CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.red.shade700,
                          child: Text(
                            mail.petugas.nama.initialName(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
              title: Text(mail.petugas.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(mail.petugas.site.nama),
            ),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.parse(mail.tanggal).ddMMMyyyy(' '),
              secondIcon: Icons.access_time_rounded,
              secondTitle: 'Shift',
              secondSubtitle: mail.shift,
            ),
            DoubleListTile(
              firstIcon: Icons.people_outline_sharp,
              firstTitle: 'Nama Pengirim',
              firstSubtitle: mail.namaPengirim ?? '-',
              secondIcon: Icons.location_on_outlined,
              secondTitle: 'Alamat Pengirim',
              secondSubtitle: mail.alamatPengirim ?? '-',
            ),
            DoubleListTile(
              firstIcon: Icons.people_outline_sharp,
              firstTitle: 'Nama Penerima',
              firstSubtitle: mail.namaPenerima ?? '-',
              secondIcon: Icons.credit_card_outlined,
              secondTitle: 'Jenis Surat',
              secondSubtitle: mail.jenisSurat ?? '-',
            ),
            DoubleListTile(
              firstIcon: Icons.local_shipping_outlined,
              firstTitle: 'Kurir',
              firstSubtitle: mail.kurir ?? '-',
              secondIcon: Icons.confirmation_number_outlined,
              secondTitle: 'No Resi',
              secondSubtitle: mail.noResi ?? '-',
            ),
            if (mail.jumlah != null) ...[
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.numbers),
                title: const Text(
                  'Jumlah',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                subtitle: Text(
                  '${mail.jumlah}',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
            if (mail.keterangan != null && mail.keterangan!.isNotEmpty) ...[
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Keterangan',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                subtitle: Text(
                  mail.keterangan!,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                leading: const Icon(Icons.description_rounded),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
