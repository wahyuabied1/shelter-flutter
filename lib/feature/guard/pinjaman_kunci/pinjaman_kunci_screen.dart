import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/debouncer/debouncer.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_info_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import '../../../data/model/guard_key_loan_response.dart';
import 'viewmodel/pinjaman_kunci_viewmodel.dart';
import 'package:intl/intl.dart';

class PinjamanKunciScreen extends StatelessWidget {
  const PinjamanKunciScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PinjamanKunciViewmodel()..init(),
      child: const _PinjamanKunciView(),
    );
  }
}

class _PinjamanKunciView extends StatefulWidget {
  const _PinjamanKunciView();

  @override
  State<_PinjamanKunciView> createState() => _PinjamanKunciViewState();
}

class _PinjamanKunciViewState extends State<_PinjamanKunciView> {
  final ScrollController _scrollController = ScrollController();
  final shimmerHeightThreshold = 68.h;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final vm = context.read<PinjamanKunciViewmodel>();
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent - shimmerHeightThreshold)) {
      _debouncer.run(() {
        vm.loadMore();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PinjamanKunciViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Pinjaman Kunci",
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
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoubleDateWidget(
                      startDate: vm.startDate,
                      endDate: vm.endDate,
                      onChangeDate: (date) {
                        vm.updateDateRange(date.start, date.end);
                      },
                      theme: ThemeWidget.blue,
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
                          const SizedBox(width: 12),
                          _buildRuangFilter(vm),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SearchWidget(
                        hint: 'Cari Peminjam',
                        onSearch: (search) => vm.updateSearchQuery(search),
                        theme: ThemeWidget.red,
                      ),
                    ),
                    if (vm.isLoading)
                      const LoadingLineShimmer()
                    else
                      Text(
                        vm.totalDataText,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              _buildContent(vm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftFilter(PinjamanKunciViewmodel vm) {
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

  Widget _buildPetugasFilter(PinjamanKunciViewmodel vm) {
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
                orElse: () => GuardKeyLoanFilterPetugas(id: 0, nama: ''),
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

  Widget _buildRuangFilter(PinjamanKunciViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableRuangan.isEmpty) return;

        final Map<String, bool> ruanganChoice = {};
        for (var ruang in vm.availableRuangan) {
          ruanganChoice[ruang.nama] = vm.selectedRuangId == ruang.id;
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Ruang Kunci",
              choice: ruanganChoice,
              theme: ThemeWidget.red,
            );
          },
        );

        if (result != null) {
          int? selectedId;
          result.forEach((key, isSelected) {
            if (isSelected) {
              final ruang = vm.availableRuangan.firstWhere(
                (r) => r.nama == key,
                orElse: () => GuardKeyLoanFilterRuangan(id: 0, nama: ''),
              );
              if (ruang.id != 0) selectedId = ruang.id;
            }
          });
          vm.updateRuangFilter(selectedId);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedRuangId == null
              ? Colors.transparent
              : Colors.red.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                vm.selectedRuangId == null ? Colors.grey.shade300 : Colors.red,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedRuangText,
              style: TextStyle(
                color: vm.selectedRuangId != null
                    ? Colors.red.shade700
                    : Colors.black,
                fontWeight: vm.selectedRuangId != null
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedRuangId != null
                  ? Colors.red.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(PinjamanKunciViewmodel vm) {
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

    if (vm.keyLoanList.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              vm.searchQuery.isNotEmpty ||
                      vm.selectedShift.isNotEmpty ||
                      vm.selectedPetugasIds.isNotEmpty ||
                      vm.selectedRuangId != null
                  ? 'Tidak ada data yang sesuai filter'
                  : 'Tidak ada data',
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Load more indicator
          if (index == vm.keyLoanList.length) {
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

          final item = vm.keyLoanList[index];
          return _card(item);
        },
        childCount: vm.keyLoanList.length + 1,
      ),
    );
  }

  Widget _card(dynamic keyLoan) {
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
              leading: keyLoan.petugas.photo != null &&
                      keyLoan.petugas.photo!.isNotEmpty
                  ? CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(keyLoan.petugas.photo!),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red.shade700,
                      child: Text(
                        keyLoan.petugas.nama.initialName(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              title: Text(keyLoan.peminjam,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(keyLoan.petugas.nama),
            ),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.parse(keyLoan.tanggal).ddMMMyyyy(' '),
              secondIcon: Icons.access_time,
              secondTitle: 'Shift',
              secondSubtitle: keyLoan.shift,
            ),
            DoubleListTile(
              firstIcon: Icons.location_on_outlined,
              firstTitle: 'Ruang Kunci',
              firstSubtitle: keyLoan.ruang.nama,
            ),
            const SizedBox(height: 8),
            DoubleInfoWidget(
              firstInfo: 'Jam Ambil',
              firstValue: keyLoan.jamAmbil ?? '-',
              secondInfo: 'Jam Kembali',
              secondValue: keyLoan.jamKembali ?? '-',
              theme: ThemeWidget.red,
            ),
            if (keyLoan.pengembali != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.person_outline,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Pengembali: ${keyLoan.pengembali}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
