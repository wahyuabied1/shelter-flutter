import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_report_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class ReportDashboardViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquReportResponse?> reportResult = const Result.initial();

  DateTime selectedDate = DateTime.now();

  // =======================
  // FILTER STATE
  // =======================
  List<int> selectedDepartemenIds = [];

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
        } else if (result.isError) {
          reportResult = Result.error(result.error);
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
  // CHART MAPPING
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

  List<Departemen> get departemenList =>
      reportResult.dataOrNull?.filter?.departemen ?? [];

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
}
