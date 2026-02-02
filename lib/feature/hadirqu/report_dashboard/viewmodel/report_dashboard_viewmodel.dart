import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_report_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

import '../../../../data/model/hadirqu_attendance_detail_response.dart';
import '../../../../data/model/hadirqu_departement_filter_response.dart';

class ReportDashboardViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquReportResponse?> reportResult = const Result.initial();
  Result<HadirquAttendanceDetailResponse?> presentDetailResult =
      const Result.initial();
  Result<HadirquAttendanceDetailResponse?> absentDetailResult =
      const Result.initial();

  DateTime selectedDate = DateTime.now();

  // =======================
  // FILTER STATE
  // =======================
  List<int> selectedDepartemenIds = [];
  List<int> selectedStatusIds = [];

  // Simpan filter departemen secara terpisah agar tidak hilang saat loading
  List<Departemen> _cachedDepartemenList = [];

  // Cache filter jabatan dari detail results
  List<String> _cachedPresentJabatanList = [];
  List<String> _cachedAbsentJabatanList = [];

  // Cache filter status from detail results
  List<StatusAbsensi> _cachedPresentStatusList = [];
  List<StatusAbsensi> _cachedAbsentStatusList = [];

  // =======================
  // INIT
  // =======================
  void init() {
    getReport();
  }

  // =======================
  // MAIN API
  // =======================
  Future<bool> getReport() {
    reportResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquReportResponse>>(
      future: _hadirquRepository.getReport(
        date: selectedDate.yyyyMMdd('-'),

        // ✅ FIX: kirim null kalau kosong biar API tidak ke-filter
        departemenIds:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final reportResponse = result.dataOrNull?.data;
          reportResult = Result.success(reportResponse);

          // Cache filter departemen agar tidak hilang saat loading berikutnya
          if (reportResponse?.filter?.departemen != null) {
            _cachedDepartemenList = reportResponse!.filter!.departemen ?? [];
          }
        } else if (result.isError) {
          reportResult = Result.error(result.error);
        }

        notifyListeners();
      },
    );
  }

  // Method untuk fetch present detail
  Future<bool> getPresentDetail() {
    presentDetailResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquAttendanceDetailResponse>>(
      future: _hadirquRepository.getAttendanceDetail(
        kehadiran: 1, // Hadir
        tanggal: selectedDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        status: selectedStatusIds.isEmpty ? null : selectedStatusIds,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          presentDetailResult = Result.success(result.dataOrNull?.data);

          // Cache jabatan list agar tidak hilang saat loading berikutnya
          if (result.dataOrNull?.data?.filter != null) {
            _cachedPresentJabatanList = result.dataOrNull!.data!.filter!.jabatan;
            _cachedPresentStatusList = result.dataOrNull!.data!.filter!.statusAbsensi;
          }
        } else if (result.isError) {
          presentDetailResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

// Method untuk fetch absent detail
  Future<bool> getAbsentDetail() {
    absentDetailResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquAttendanceDetailResponse>>(
      future: _hadirquRepository.getAttendanceDetail(
        kehadiran: 0, // Tidak hadir
        tanggal: selectedDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        status: selectedStatusIds.isEmpty ? null : selectedStatusIds,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          absentDetailResult = Result.success(result.dataOrNull?.data);

          // Cache jabatan list agar tidak hilang saat loading berikutnya
          if (result.dataOrNull?.data?.filter != null) {
            _cachedAbsentJabatanList = result.dataOrNull!.data!.filter!.jabatan;
            _cachedAbsentStatusList = result.dataOrNull!.data!.filter!.statusAbsensi;
          }
        } else if (result.isError) {
          absentDetailResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  // =======================
  // ACTIONS
  // =======================

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
    getReport();
  }

  /// Toggle satu departemen
  void toggleDepartemen(int departemenId) {
    if (selectedDepartemenIds.contains(departemenId)) {
      selectedDepartemenIds.remove(departemenId);
    } else {
      selectedDepartemenIds.add(departemenId);
    }

    notifyListeners();
    getReport();
  }

  /// Update langsung dari MultiChoice
  void updateDepartemenFilter(List<int> ids) {
    selectedDepartemenIds = ids;

    notifyListeners();
    getReport();
  }

  void clearDepartemenFilter() {
    selectedDepartemenIds.clear();

    notifyListeners();
    getReport();
  }

  bool isDepartemenSelected(int departemenId) {
    return selectedDepartemenIds.contains(departemenId);
  }

  // =======================
  // GETTER DATA
  // =======================

  HadirquReportData? get data => reportResult.dataOrNull?.data;

  bool get isLoading => reportResult.isInitialOrLoading;

  bool get isError => reportResult.isError;

  // =======================
  // MAPPING
  // =======================

  Map<String, double> get presentChart {
    if (data == null) return {};

    return {
      "Hadir": data!.kehadiran?.toDouble() ?? 0,
      "Terlambat": data!.terlambat?.toDouble() ?? 0,
      "Di luar lokasi": data!.diluarLokasi?.toDouble() ?? 0,
      "Pulang cepat": data!.pulangCepat?.toDouble() ?? 0,
    };
  }

  Map<String, double> get absentChart {
    if (data == null) return {};

    return {
      "Sakit": data!.sakit?.toDouble() ?? 0,
      "Izin": data!.izin?.toDouble() ?? 0,
      "Cuti": data!.cuti?.toDouble() ?? 0,
      "Alpha": data!.alpha?.toDouble() ?? 0,
    };
  }

  List<AttendanceDetail> get presentList =>
      presentDetailResult.dataOrNull?.data ?? [];

  List<AttendanceDetail> get absentList =>
      absentDetailResult.dataOrNull?.data ?? [];

  // =======================
  // TEXT HELPER
  // =======================

  String get centerPresentText {
    if (data == null) return "0/0";
    return "${data!.kehadiran ?? 0}/${data!.jumlahKaryawan ?? 0}";
  }

  String get centerNotPresentText {
    if (data == null) return "0/0";
    return "${data!.ketidakhadiran ?? 0}/${data!.jumlahKaryawan ?? 0}";
  }

  String get clockInPertama => data?.clockinPertama ?? "-";

  String get clockOutTerakhir => data?.clockoutTerakhir ?? "-";

  String get clockInAvg => data?.clockinAvg ?? "-";

  String get clockOutAvg => data?.clockoutAvg ?? "-";

  String get durasiAvg => data?.durasiAvg ?? "-";

  String get durasiIstirahatAvg => data?.durasiIstirahatAvg ?? "-";

  // =======================
  // FILTER DATA
  // =======================

  List<Departemen> get departemenList {
    // Gunakan cached list agar filter tidak hilang saat loading
    if (_cachedDepartemenList.isNotEmpty) {
      return _cachedDepartemenList;
    }
    return reportResult.dataOrNull?.filter?.departemen ?? [];
  }

  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) {
      return 'Semua Departemen';
    }

    if (selectedDepartemenIds.length == 1) {
      final dept = departemenList.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () => Departemen(
          id: 0,
          nama: 'Unknown',
          totalPegawai: 0,
        ),
      );

      return dept.nama ?? 'Unknown';
    }

    return '${selectedDepartemenIds.length} Departemen Dipilih';
  }

  // Jabatan lists dengan caching
  List<String> get presentJabatanList {
    // Gunakan cached list agar filter tidak hilang saat loading
    if (_cachedPresentJabatanList.isNotEmpty) {
      return _cachedPresentJabatanList;
    }
    return presentDetailResult.dataOrNull?.filter?.jabatan ?? [];
  }

  List<String> get absentJabatanList {
    // Gunakan cached list agar filter tidak hilang saat loading
    if (_cachedAbsentJabatanList.isNotEmpty) {
      return _cachedAbsentJabatanList;
    }
    return absentDetailResult.dataOrNull?.filter?.jabatan ?? [];
  }

  // Status lists dengan caching
  List<StatusAbsensi> get presentStatusList {
    // Gunakan cached list agar filter tidak hilang saat loading
    if (_cachedPresentStatusList.isNotEmpty) {
      return _cachedPresentStatusList;
    }
    return presentDetailResult.dataOrNull?.filter?.statusAbsensi ?? [];
  }

  List<StatusAbsensi> get absentStatusList {
    // Gunakan cached list agar filter tidak hilang saat loading
    if (_cachedAbsentStatusList.isNotEmpty) {
      return _cachedAbsentStatusList;
    }
    return absentDetailResult.dataOrNull?.filter?.statusAbsensi ?? [];
  }

  // =======================
  // STATUS FILTER ACTIONS
  // =======================

  /// Update status filter dan refresh detail
  void updateStatusFilter(List<int> statusIds) {
    selectedStatusIds = statusIds;
    notifyListeners();
  }

  void clearStatusFilter() {
    selectedStatusIds.clear();
    notifyListeners();
  }

  bool isStatusSelected(int statusId) {
    return selectedStatusIds.contains(statusId);
  }

  String get selectedStatusText {
    if (selectedStatusIds.isEmpty) {
      return 'Semua Status';
    }

    if (selectedStatusIds.length == 1) {
      // Ambil dari cache yang sudah ada
      final allStatus = [
        ..._cachedPresentStatusList,
        ..._cachedAbsentStatusList,
      ];

      final status = allStatus.firstWhere(
        (s) => s.status == selectedStatusIds.first,
        orElse: () => StatusAbsensi(status: 0, text: 'Unknown'),
      );

      return status.text;
    }

    return '${selectedStatusIds.length} Status Dipilih';
  }
}
