import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../data/model/guard_transporter_response.dart';
import 'viewmodel/transporter_viewmodel.dart';

class TransporterScreen extends StatelessWidget {
  const TransporterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransporterViewmodel()..init(),
      child: const _TransporterView(),
    );
  }
}

class _TransporterView extends StatefulWidget {
  const _TransporterView();

  @override
  State<_TransporterView> createState() => _TransporterViewState();
}

class _TransporterViewState extends State<_TransporterView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final vm = context.read<TransporterViewmodel>();
      if (vm.hasMore && !vm.isLoadingMore) {
        vm.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransporterViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Transporter",
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
      body: RefreshIndicator(
        color: Colors.red,
        backgroundColor: Colors.white,
        onRefresh: () => vm.loadInitial(),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: _scrollController,
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
                    _buildPetugasFilter(vm),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: SearchWidget(
                  hint: 'Cari Transporter',
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
      ),
    );
  }

  Widget _buildPetugasFilter(TransporterViewmodel vm) {
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
                orElse: () => GuardTransporterFilterPetugas(id: 0, nama: ''),
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

  Widget _buildContent(TransporterViewmodel vm) {
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
                onPressed: () => vm.loadInitial(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (vm.transporterList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            vm.searchQuery.isNotEmpty || vm.selectedPetugasIds.isNotEmpty
                ? 'Tidak ada data yang sesuai filter'
                : 'Tidak ada data',
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vm.transporterList.length + 1, // +1 untuk load more indicator
      itemBuilder: (context, index) {
        // Load more indicator
        if (index == vm.transporterList.length) {
          return vm.hasMore
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Semua data telah ditampilkan',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
        }

        final item = vm.transporterList[index];
        return _card(item);
      },
    );
  }

  Widget _card(dynamic transporter) {
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
              leading: transporter.petugas.photo != null &&
                      transporter.petugas.photo!.isNotEmpty
                  ? CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(transporter.petugas.photo!),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red.shade700,
                      child: Text(
                        transporter.petugas.nama.initialName(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              title: Text(transporter.petugas.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(transporter.petugas.site.nama),
            ),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.parse(transporter.tanggal).ddMMMyyyy(' '),
              secondIcon: Icons.directions_car,
              secondTitle: 'No Kendaraan',
              secondSubtitle: transporter.noKendaraan ?? '-',
            ),
            DoubleListTile(
              firstIcon: Icons.commute,
              firstTitle: 'Jenis Kendaraan',
              firstSubtitle: transporter.jenisKendaraan ?? '-',
              secondIcon: Icons.factory_outlined,
              secondTitle: 'Perusahaan Angkutan',
              secondSubtitle: transporter.perusahaanAngkutan ?? '-',
            ),
            if (transporter.namaBarang != null &&
                transporter.namaBarang!.isNotEmpty) ...[
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Nama Barang',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                subtitle: Text(
                  transporter.namaBarang!,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                leading: const Icon(Icons.inventory_2_outlined),
              ),
            ],
            if (transporter.keterangan != null &&
                transporter.keterangan!.isNotEmpty) ...[
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Keterangan',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                subtitle: Text(
                  transporter.keterangan!,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                leading: const Icon(Icons.description_rounded),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  DoubleListTile(
                    firstIcon: Icons.person_2_outlined,
                    firstTitle: 'Sopir',
                    firstSubtitle: transporter.sopir ?? '-',
                    secondIcon: Icons.phone,
                    secondTitle: 'Telepon',
                    secondSubtitle: transporter.telpon ?? '-',
                  ),
                  DoubleListTile(
                    firstIcon: Icons.access_time_outlined,
                    firstTitle: 'Jam Masuk',
                    firstSubtitle: transporter.masuk ?? '-',
                    secondIcon: Icons.access_time_outlined,
                    secondTitle: 'Jam Keluar',
                    secondSubtitle: transporter.keluar ?? '-',
                  ),
                ],
              ),
            ),
            if (transporter.noSurat != null &&
                    transporter.noSurat!.isNotEmpty ||
                transporter.noContainer != null &&
                    transporter.noContainer!.isNotEmpty) ...[
              const SizedBox(height: 8),
              DoubleListTile(
                firstIcon: Icons.numbers,
                firstTitle: 'No Surat',
                firstSubtitle: transporter.noSurat ?? '-',
                secondIcon: Icons.inventory,
                secondTitle: 'No Container',
                secondSubtitle: transporter.noContainer ?? '-',
              ),
            ],
            if (transporter.ktp != null && transporter.ktp!.isNotEmpty ||
                transporter.suratJalan != null &&
                    transporter.suratJalan!.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Divider(),
              const Text(
                'Dokumen',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (transporter.ktp != null && transporter.ktp!.isNotEmpty) ...[
              _buildDocumentTile('KTP', transporter.ktp!),
            ],
            if (transporter.suratJalan != null &&
                transporter.suratJalan!.isNotEmpty) ...[
              _buildDocumentTile('Surat Jalan', transporter.suratJalan!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile(String label, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        leading: const Icon(Icons.image),
        trailing: const Icon(Icons.open_in_new),
      ),
    );
  }
}
