import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_overtime_report_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class OvertimeReportViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquOvertimeReportResponse?> overtimeResult =
      const Result.initial();

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedDepartemenIds = [];
  List<int> selectedStatus = [];
  String searchQuery = '';

  void init() {
    getOvertimeReport();
  }

  Future<bool> getOvertimeReport() {
    overtimeResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquOvertimeReportResponse>>(
      future: _hadirquRepository.getOvertimeReport(
        tanggalMulai: startDate.yyyyMMdd('-'),
        tanggalAkhir: endDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        status: selectedStatus.isEmpty ? null : selectedStatus,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          overtimeResult = Result.success(result.dataOrNull?.data);
        } else if (result.isError) {
          overtimeResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    notifyListeners();
    getOvertimeReport();
  }

  void updateDepartemenFilter(List<int> departemenIds) {
    selectedDepartemenIds = departemenIds;
    notifyListeners();
    getOvertimeReport();
  }

  void updateStatusFilter(List<int> statusIds) {
    selectedStatus = statusIds;
    notifyListeners();
    getOvertimeReport();
  }

  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    notifyListeners();
  }

  void resetFilters() {
    selectedDepartemenIds = [];
    selectedStatus = [];
    searchQuery = '';
    notifyListeners();
    getOvertimeReport();
  }

  // =======================
  // Helper untuk UI
  // =======================

  HadirquOvertimeReportResponse? get data => overtimeResult.dataOrNull;

  bool get isLoading => overtimeResult.isInitialOrLoading;

  bool get isError => overtimeResult.isError;

  List<OvertimeReport> get overtimeList {
    final list = data?.data ?? [];

    if (searchQuery.isEmpty) return list;

    return list.where((overtime) {
      return overtime.pemohon.nama.toLowerCase().contains(searchQuery) ||
          overtime.pemohon.idPegawai.toLowerCase().contains(searchQuery) ||
          overtime.pemohon.departemen.toLowerCase().contains(searchQuery);
    }).toList();
  }

  int get totalData => overtimeList.length;

  List<OvertimeDepartemen> get availableDepartemen =>
      data?.filter.departemen ?? [];

  List<OvertimeStatus> get availableStatus => data?.filter.status ?? [];

  // Text untuk filter buttons
  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) return 'Departemen';
    if (selectedDepartemenIds.length == 1) {
      final dept = availableDepartemen.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () =>
            OvertimeDepartemen(id: 0, nama: 'Unknown', totalPegawai: 0),
      );
      return dept.nama;
    }
    return 'Departemen (${selectedDepartemenIds.length})';
  }

  String get selectedStatusText {
    if (selectedStatus.isEmpty) return 'Status';
    if (selectedStatus.length == 1) {
      final status = availableStatus.firstWhere(
        (s) => s.id == selectedStatus.first,
        orElse: () => OvertimeStatus(id: 0, nama: 'Unknown'),
      );
      return status.nama;
    }
    return 'Status (${selectedStatus.length})';
  }
}
