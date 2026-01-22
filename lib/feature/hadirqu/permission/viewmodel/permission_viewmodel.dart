import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_leave_report_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class PermissionViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquLeaveReportResponse?> leaveResult = const Result.initial();

  DateTime selectedDate = DateTime.now();

  // Filter states
  List<int> selectedDepartemenIds = [];
  List<int> selectedStatus = [];

  void init() {
    getLeaveReport();
  }

  Future<bool> getLeaveReport() {
    leaveResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquLeaveReportResponse>>(
      future: _hadirquRepository.getLeaveReport(
        tanggalMulai: selectedDate.yyyyMMdd('-'),
        tanggalSelesai: selectedDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        status: selectedStatus.isEmpty ? null : selectedStatus,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          leaveResult = Result.success(result.dataOrNull?.data);
        } else if (result.isError) {
          leaveResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
    getLeaveReport();
  }

  void updateDepartemenFilter(List<int> departemenIds) {
    selectedDepartemenIds = departemenIds;
    notifyListeners();
    getLeaveReport();
  }

  void updateStatusFilter(List<int> statusIds) {
    selectedStatus = statusIds;
    notifyListeners();
    getLeaveReport();
  }

  void resetFilters() {
    selectedDepartemenIds = [];
    selectedStatus = [];
    notifyListeners();
    getLeaveReport();
  }

  // =======================
  // Helper untuk UI
  // =======================

  HadirquLeaveReportResponse? get data => leaveResult.dataOrNull;

  bool get isLoading => leaveResult.isInitialOrLoading;

  bool get isError => leaveResult.isError;

  List<LeaveReport> get leaveList => data?.data ?? [];

  int get totalLeave => leaveList.length;

  List<LeaveDepartemen> get availableDepartemen =>
      data?.filter.departemen ?? [];

  List<LeaveStatus> get availableStatus => data?.filter.status ?? [];

  // Text untuk filter buttons
  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) return 'Departemen';
    if (selectedDepartemenIds.length == 1) {
      final dept = availableDepartemen.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () => LeaveDepartemen(id: 0, nama: 'Unknown', totalPegawai: 0),
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
        orElse: () => LeaveStatus(id: 0, nama: 'Unknown'),
      );
      return status.nama;
    }
    return 'Status (${selectedStatus.length})';
  }
}
