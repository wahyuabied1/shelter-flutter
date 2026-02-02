import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_presence_list_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

import '../../../../data/model/hadirqu_departement_filter_response.dart';
import '../../../../data/model/hadirqu_presence_detail_response.dart';
import 'contract/presence_detail_contract.dart';

class PresenceLogViewmodel extends ABaseChangeNotifier
    implements PresenceDetailContract {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquPresenceListResponse?> presenceResult = const Result.initial();

  @override
  Result<HadirquPresenceDetailResponse?> presenceDetailResult =
      const Result.initial();

  DateTime startDate = DateTime(2025, 1, 1);
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedDepartemenIds = [];
  List<String> selectedJabatan = [];
  int? filterKehadiran;
  String? filterKehadiranPersamaan;
  int? filterKehadiranNilai;

  // Pagination states
  int _offset = 0;
  bool _hasMore = true;
  bool isLoadMoreInProgress = false;
  List<PresenceData> _allPresenceList = [];

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _offset = 0;
    _allPresenceList = [];
    _hasMore = true;
    await _fetchPresenceList(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_hasMore) {
      if (isLoadMoreInProgress) {
        return Future(() => []);
      } else {
        isLoadMoreInProgress = true;
        await _fetchPresenceList(isLoadMore: true);
      }
    }
  }

  Future<bool> _fetchPresenceList({required bool isLoadMore}) {
    if (!isLoadMore) {
      presenceResult = const Result.loading();
      notifyListeners();
    }

    return Result.callApi<JsonResponse<HadirquPresenceListResponse>>(
      future: _hadirquRepository.getLogPresenceList(
        tanggalMulai: startDate.yyyyMMdd('-'),
        tanggalSelesai: endDate.yyyyMMdd('-'),
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        jabatan: selectedJabatan.isEmpty ? null : selectedJabatan,
        filterKehadiran: filterKehadiran,
        filterKehadiranPersamaan: filterKehadiranPersamaan,
        filterKehadiranNilai: filterKehadiranNilai,
        limit: 10,
        offset: _offset,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final presenceResponse = result.dataOrNull?.data;
          final newItems = presenceResponse?.data ?? [];

          if (isLoadMore) {
            _allPresenceList.addAll(newItems);
          } else {
            _allPresenceList = List.from(newItems);
          }

          _hasMore = newItems.length >= 10;
          _offset = _allPresenceList.length;

          presenceResult = Result.success(presenceResponse);
        } else if (result.isError) {
          presenceResult = Result.error(result.error);
        }
        isLoadMoreInProgress = false;
        notifyListeners();
      },
    );
  }

  // Kept for backward compatibility
  Future<bool> getPresenceList() async {
    await loadInitial();
    return true;
  }

  @override
  Future<bool> getPresenceDetail(int idKaryawan) {
    presenceDetailResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquPresenceDetailResponse>>(
      future: _hadirquRepository.getPresenceLogDetail(
        tanggalMulai: startDate.yyyyMMdd('-'),
        tanggalSelesai: endDate.yyyyMMdd('-'),
        idKaryawan: idKaryawan,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final detailResponse = result.dataOrNull?.data;
          presenceDetailResult = Result.success(detailResponse);
        } else if (result.isError) {
          presenceDetailResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    notifyListeners();
    loadInitial();
  }

  void updateDepartemenFilter(List<int> departemenIds) {
    selectedDepartemenIds = departemenIds;
    notifyListeners();
    loadInitial();
  }

  void updateJabatanFilter(List<String> jabatan) {
    selectedJabatan = jabatan;
    notifyListeners();
    loadInitial();
  }

  void updateKehadiranFilter({
    required int statusCode,
    required String operator,
    required int nilai,
  }) {
    filterKehadiran = statusCode;
    filterKehadiranPersamaan = operator;
    filterKehadiranNilai = nilai;
    notifyListeners();
    loadInitial();
  }

  void resetKehadiranFilter() {
    filterKehadiran = null;
    filterKehadiranPersamaan = null;
    filterKehadiranNilai = null;
    notifyListeners();
    loadInitial();
  }

  void resetAllFilters() {
    selectedDepartemenIds = [];
    selectedJabatan = [];
    filterKehadiran = null;
    filterKehadiranPersamaan = null;
    filterKehadiranNilai = null;
    notifyListeners();
    loadInitial();
  }

  // =======================
  // Helper untuk UI
  // =======================

  HadirquPresenceListResponse? get data => presenceResult.dataOrNull;

  bool get isLoading => presenceResult.isInitialOrLoading;

  bool get isError => presenceResult.isError;

  bool get hasMore => _hasMore;

  List<PresenceData> get presenceList => _allPresenceList;

  int get totalKaryawan => _allPresenceList.length;

  List<Departemen> get availableDepartemen => data?.filter.departemen ?? [];

  List<String> get availableJabatan => data?.filter.jabatan ?? [];

  List<StatusAbsensi> get availableStatusAbsensi =>
      data?.filter.statusAbsensi ?? [];

  // Text untuk filter departemen button
  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) {
      return 'Departemen';
    } else if (selectedDepartemenIds.length == 1) {
      final dept = availableDepartemen.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () => Departemen(id: 0, nama: 'Unknown', totalPegawai: 0),
      );
      return dept.nama;
    } else {
      return 'Departemen (${selectedDepartemenIds.length})';
    }
  }

  // Text untuk filter jabatan button
  String get selectedJabatanText {
    if (selectedJabatan.isEmpty) {
      return 'Jabatan';
    } else if (selectedJabatan.length == 1) {
      return selectedJabatan.first;
    } else {
      return 'Jabatan (${selectedJabatan.length})';
    }
  }

  bool get hasKehadiranFilter => filterKehadiran != null;

  List<Map<String, dynamic>> convertToAttendanceData(
    Map<String, int> kodePresensi,
    Map<String, int> presensiText,
  ) {
    final List<Map<String, dynamic>> result = [];

    int dayCounter = 1;

    kodePresensi.forEach((kode, jumlah) {
      final desc = presensiText.keys.firstWhere(
        (text) =>
            text.toLowerCase().contains(kode.toLowerCase().replaceAll('&', '')),
        orElse: () => kode,
      );

      // Split "? & t" → ["?", "t"]
      final types = kode.split('&').map((e) => e.trim().toUpperCase()).toList();

      for (int i = 0; i < jumlah; i++) {
        result.add({
          'day': dayCounter++,
          'statuses': types.map((t) => {'type': t}).toList(),
          'desc': desc,
        });
      }
    });

    return result;
  }
}
