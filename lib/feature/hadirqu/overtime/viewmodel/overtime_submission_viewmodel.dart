import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/platform/geocoding/geocoding_service_impl.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_overtime_submission_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';
import '../../../../core/platform/geocoding/geocoding_service.dart';

class OvertimeSubmissionViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();
  final _geocodingService = GeocodingServiceImpl();

  Result<HadirquOvertimeSubmissionResponse?> submissionResult =
      const Result.initial();

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedDepartemenIds = [];
  List<int> selectedStatus = [];
  String searchQuery = '';

  // Address caching untuk menghindari geocoding berulang
  final Map<String, String> _addressCache = {};
  final Map<String, bool> _loadingAddresses = {};

  void init() {
    getOvertimeSubmission();
  }

  Future<bool> getOvertimeSubmission() {
    submissionResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquOvertimeSubmissionResponse>>(
      future: _hadirquRepository.getOvertimeSubmission(
        tanggalMulai: startDate.yyyyMMdd('-'),
        tanggalAkhir: endDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        status: selectedStatus.isEmpty ? null : selectedStatus,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          submissionResult = Result.success(result.dataOrNull?.data);
        } else if (result.isError) {
          submissionResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    notifyListeners();
    getOvertimeSubmission();
  }

  void updateDepartemenFilter(List<int> departemenIds) {
    selectedDepartemenIds = departemenIds;
    notifyListeners();
    getOvertimeSubmission();
  }

  void updateStatusFilter(List<int> statusIds) {
    selectedStatus = statusIds;
    notifyListeners();
    getOvertimeSubmission();
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
    getOvertimeSubmission();
  }

  // Geocoding methods
  Future<String> getAddress(String lat, String long) async {
    final key = '$lat,$long';

    // Return dari cache jika sudah ada
    if (_addressCache.containsKey(key)) {
      return _addressCache[key]!;
    }

    // Jika sedang loading, tunggu
    if (_loadingAddresses[key] == true) {
      return 'Memuat alamat...';
    }

    // Mulai loading
    _loadingAddresses[key] = true;

    try {
      final latitude = double.tryParse(lat) ?? 0.0;
      final longitude = double.tryParse(long) ?? 0.0;

      final address = await _geocodingService.getAddressFromLatLng(
        latitude: latitude,
        longitude: longitude,
      );

      final result = address ?? 'Alamat tidak ditemukan';
      _addressCache[key] = result;
      _loadingAddresses[key] = false;

      notifyListeners();
      return result;
    } catch (e) {
      _loadingAddresses[key] = false;
      final errorResult = 'Gagal memuat alamat';
      _addressCache[key] = errorResult;
      return errorResult;
    }
  }

  bool isLoadingAddress(String lat, String long) {
    final key = '$lat,$long';
    return _loadingAddresses[key] == true;
  }

  String? getCachedAddress(String lat, String long) {
    final key = '$lat,$long';
    return _addressCache[key];
  }

  // =======================
  // Helper untuk UI
  // =======================

  HadirquOvertimeSubmissionResponse? get data => submissionResult.dataOrNull;

  bool get isLoading => submissionResult.isInitialOrLoading;

  bool get isError => submissionResult.isError;

  List<OvertimeSubmission> get submissionList {
    final list = data?.data ?? [];

    if (searchQuery.isEmpty) return list;

    return list.where((submission) {
      return submission.pemohon.nama.toLowerCase().contains(searchQuery) ||
          (submission.pemohon.idPegawai?.toLowerCase().contains(searchQuery) ??
              false) ||
          submission.keterangan.toLowerCase().contains(searchQuery);
    }).toList();
  }

  int get totalData => submissionList.length;

  List<OvertimeSubmissionDepartemen> get availableDepartemen =>
      data?.filter.departemen ?? [];

  List<OvertimeSubmissionStatus> get availableStatus =>
      data?.filter.status ?? [];

  // Text untuk filter buttons
  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) return 'Departemen';
    if (selectedDepartemenIds.length == 1) {
      final dept = availableDepartemen.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () => OvertimeSubmissionDepartemen(
          id: 0,
          nama: 'Unknown',
          totalPegawai: 0,
        ),
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
        orElse: () => OvertimeSubmissionStatus(id: 0, nama: 'Unknown'),
      );
      return status.nama;
    }
    return 'Status (${selectedStatus.length})';
  }
}
