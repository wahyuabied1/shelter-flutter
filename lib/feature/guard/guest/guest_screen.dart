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
import 'package:intl/intl.dart';
import '../../../core/utils/common.dart';
import '../../../data/model/guard_guest_response.dart';
import '../../../design/default_snackbar.dart';
import '../../../design/show_image.dart';
import 'viewmodel/guest_viewmodel.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GuestViewmodel()..init(),
      child: const _GuestView(),
    );
  }
}

class _GuestView extends StatefulWidget {
  const _GuestView();

  @override
  State<_GuestView> createState() => _GuestViewState();
}

class _GuestViewState extends State<_GuestView> {
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
      final vm = context.read<GuestViewmodel>();
      if (vm.hasMore && !vm.isLoadingMore) {
        vm.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GuestViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Tamu",
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
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header Section (Filters, Search, etc)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      hint: 'Cari Nama Tamu',
                      onSearch: (search) => vm.updateSearchQuery(search),
                      theme: ThemeWidget.red,
                    ),
                  ),
                  if (vm.isLoading)
                    const LoadingLineShimmer()
                  else
                    Text(
                      vm.totalDataText,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Content Section
            _buildContent(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftFilter(GuestViewmodel vm) {
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

  Widget _buildPetugasFilter(GuestViewmodel vm) {
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
                orElse: () => GuardGuestFilterPetugas(id: 0, nama: ''),
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

  Widget _buildContent(GuestViewmodel vm) {
    if (vm.isLoading) {
      return const SliverToBoxAdapter(
        child: LoadingListShimmer(
          marginHorizontal: false,
        ),
      );
    }

    if (vm.isError) {
      return SliverToBoxAdapter(
        child: Center(
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
        ),
      );
    }

    if (vm.guestList.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
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
        ),
      );
    }

    // ✅ SLIVERLIST - Optimal untuk infinite scroll
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Load more indicator
          if (index == vm.guestList.length) {
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

          final item = vm.guestList[index];
          return _card(item);
        },
        childCount: vm.guestList.length + 1, // +1 untuk indicator
      ),
    );
  }

  Widget _card(dynamic guest) {
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
                  guest.petugas.photo != null && guest.petugas.photo!.isNotEmpty
                      ? CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(guest.petugas.photo!),
                        )
                      : CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.red.shade700,
                          child: Text(
                            guest.petugas.nama.initialName(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
              title: Text(guest.petugas.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(guest.petugas.site.nama),
            ),
            const Divider(),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.parse(guest.tanggal).ddMMMyyyy(' '),
              secondIcon: Icons.access_time,
              secondTitle: 'Shift',
              secondSubtitle: guest.shift,
            ),
            DoubleListTile(
              firstIcon: Icons.apartment,
              firstTitle: 'Departemen',
              firstSubtitle: guest.departemen ?? '-',
              secondIcon: Icons.task_outlined,
              secondTitle: 'Keperluan',
              secondSubtitle: guest.keperluan ?? '-',
            ),
            _buildExpandableSection(
              Icons.person_2_outlined,
              'Nama Tamu',
              guest.namaTamu ?? '-',
              [
                if (guest.namaPerusahaan != null)
                  _buildListTile(Icons.apartment, 'Nama Perusahaan',
                      guest.namaPerusahaan!),
              ],
            ),
            _buildExpandableSection(
              Icons.person_outline,
              'Orang yang Ditemui',
              guest.tujuan ?? '-',
              [
                if (guest.departemen != null)
                  _buildListTile(null, 'Departemen', guest.departemen!),
                if (guest.keperluan != null)
                  _buildListTile(null, 'Keperluan', guest.keperluan!),
              ],
            ),
            DoubleListTile(
              firstIcon: Icons.access_time_outlined,
              firstTitle: 'Jam Masuk',
              firstSubtitle: guest.masuk ?? '-',
              secondIcon: Icons.access_time_outlined,
              secondTitle: 'Jam Keluar',
              secondSubtitle: guest.keluar ?? '-',
            ),
            if (guest.keterangan != null && guest.keterangan!.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Keterangan',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                subtitle: Text(
                  guest.keterangan!,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                leading: const Icon(Icons.description_rounded),
              ),
            ],
            if (guest.photo.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...guest.photo.asMap().entries.map((entry) {
                final photoUrl = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    onTap: () async {
                      if (photoUrl != "") {
                        saveToGallery(photoUrl).then((data) {
                          showDefaultSuccessShowFile(
                              context, "Gambar berhasil disimpan", () {
                            showImage(context, data['filePath']);
                          });
                        });
                      } else if (photoUrl != "") {
                        saveToGallery(photoUrl.toString());
                      } else {
                        showDefaultError(
                            context, "Bukti download tidak ditemukan");
                      }
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    title: const Text(
                      'Foto',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    leading: const Icon(Icons.image),
                    trailing: const Icon(Icons.download),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData? icon, String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading:
          icon != null ? Icon(icon, size: 20, color: Colors.grey[600]) : null,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      dense: true,
    );
  }

  Widget _buildExpandableSection(
      IconData icon, String title, String subtitle, List<Widget> children) {
    if (children.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      );
    }

    return Card(
      color: Colors.white,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ExpansionTile(
          collapsedShape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          tilePadding: EdgeInsets.zero,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          children: children,
        ),
      ),
    );
  }
}
