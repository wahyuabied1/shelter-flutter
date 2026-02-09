import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/debouncer/debouncer.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:intl/intl.dart';
import '../../../data/model/guard_project_response.dart';
import 'viewmodel/project_viewmodel.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectViewmodel()..init(),
      child: const _ProjectView(),
    );
  }
}

class _ProjectView extends StatefulWidget {
  const _ProjectView();

  @override
  State<_ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<_ProjectView> {
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
    final vm = context.read<ProjectViewmodel>();
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent - shimmerHeightThreshold)) {
      _debouncer.run(() {
        vm.loadMore();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Proyek",
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
              //       DoubleDateWidget(
              // endDate: vm.endDate.ddMMyyyy('/'),
              // startDate: vm.startDate.ddMMyyyy('/'),
              // onChangeDate: (date) {
              //   final parsed = DateFormat('dd/MM/yyyy').parse(date);
              //
              //   vm.updateStartDate(parsed);
              // },
              // onChangeEndDate: (date) {
              //   final parsed = DateFormat('dd/MM/yyyy').parse(date);
              //
              //   vm.updateEndDate(parsed);
              // },
              //         theme: ThemeWidget.red,
              //       ),
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
                hint: 'Cari Proyek',
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

  Widget _buildPetugasFilter(ProjectViewmodel vm) {
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
                orElse: () => GuardProjectFilterPetugas(id: 0, nama: ''),
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

  Widget _buildContent(ProjectViewmodel vm) {
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

    if (vm.projectList.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              vm.searchQuery.isNotEmpty || vm.selectedPetugasIds.isNotEmpty
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
          if (index == vm.projectList.length) {
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

          final item = vm.projectList[index];
          return _card(item);
        },
        childCount: vm.projectList.length + 1,
      ),
    );
  }

  Widget _card(dynamic project) {
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
              leading: project.petugas.photo != null &&
                      project.petugas.photo!.isNotEmpty
                  ? CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(project.petugas.photo!),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red.shade700,
                      child: Text(
                        project.petugas.nama.initialName(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              title: Text(project.petugas.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(project.petugas.site.nama),
            ),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.parse(project.tanggal).ddMMMyyyy(' '),
              secondIcon: Icons.location_on_outlined,
              secondTitle: 'Area Pekerjaan',
              secondSubtitle: project.areaPekerjaan ?? '-',
            ),
            DoubleListTile(
              firstIcon: Icons.factory_outlined,
              firstTitle: 'Nama Pekerjaan',
              firstSubtitle: project.namaPekerjaan ?? '-',
              secondIcon: Icons.apartment,
              secondTitle: 'Nama Perusahaan',
              secondSubtitle: project.namaPerusahaan ?? '-',
            ),
            DoubleListTile(
              firstIcon: Icons.person_2_outlined,
              firstTitle: 'Nama Pekerja',
              firstSubtitle: project.namaPekerja ?? '-',
            ),
            if (project.keterangan != null &&
                project.keterangan!.isNotEmpty) ...[
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
                  project.keterangan!,
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
                    firstIcon: Icons.access_time_outlined,
                    firstTitle: 'Jam Masuk',
                    firstSubtitle: project.masuk ?? '-',
                    secondIcon: Icons.access_time_outlined,
                    secondTitle: 'Jam Keluar',
                    secondSubtitle: project.keluar ?? '-',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
