import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_operasional_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class KendaraanOperasionalViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardOperasionalResponse?> operasionalResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedPetugasIds = [];
  int? selectedKendaraanId;
  String searchQuery = '';

  // Pagination states
  static const int _pageSize = 10;
  int _limit = 10;
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<GuardOperasional> _allOperasional = [];

  // Filter data (dari response pertama)
  GuardOperasionalFilter? _filter;

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _limit = _pageSize;
    _offset = 0;
    _allOperasional = [];
    _hasMore = true;
    _filter = null;
    await _fetchOperasional(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || operasionalResult.isInitialOrLoading) {
      return;
    }
    _offset = _limit;
    _limit += _pageSize;
    await _fetchOperasional(isLoadMore: true);
  }

  Future<bool> _fetchOperasional({required bool isLoadMore}) {
    if (!isLoadMore) {
      operasionalResult = const Result.loading();
      notifyListeners();
    } else {
      _isLoadingMore = true;
      notifyListeners();
    }

    return Result.callApi<JsonResponse<GuardOperasionalResponse>>(
      future: _guardRepository.getOperasional(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        idKendaraan: selectedKendaraanId,
        search: searchQuery.isEmpty ? null : searchQuery,
        limit: _limit,
        offset: _offset,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final response = result.dataOrNull?.data;
          final newItems = response?.data ?? [];

          // Simpan filter dari response pertama
          if (!isLoadMore && response?.filter != null) {
            _filter = response!.filter;
          }

          if (isLoadMore) {
            _allOperasional.addAll(newItems);
          } else {
            _allOperasional = List.from(newItems);
          }

          _hasMore = newItems.length >= _pageSize;

          operasionalResult = Result.success(response);
        } else if (result.isError) {
          operasionalResult = Result.error(result.error);
        }

        _isLoadingMore = false;
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    loadInitial();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    loadInitial();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    loadInitial();
  }

  void updateKendaraanFilter(int? kendaraanId) {
    selectedKendaraanId = kendaraanId;
    notifyListeners();
    loadInitial();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    loadInitial();
  }

  void resetFilters() {
    selectedPetugasIds = [];
    selectedKendaraanId = null;
    searchQuery = '';
    notifyListeners();
    loadInitial();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  bool get isLoading => operasionalResult.isInitialOrLoading;

  bool get isError => operasionalResult.isError;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMore => _hasMore;

  List<GuardOperasional> get operasionalList => _allOperasional;

  int get totalData => _allOperasional.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<GuardOperasionalFilterKendaraan> get availableKendaraan =>
      _filter?.kendaraan ?? [];

  List<GuardOperasionalFilterPetugas> get availablePetugas =>
      _filter?.petugas ?? [];

  // Text untuk filter buttons
  String get selectedPetugasText {
    if (selectedPetugasIds.isEmpty) return 'Petugas';
    if (selectedPetugasIds.length == 1) {
      final petugas = availablePetugas.firstWhere(
        (p) => p.id == selectedPetugasIds.first,
        orElse: () => GuardOperasionalFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }

  String get selectedKendaraanText {
    if (selectedKendaraanId == null) return 'No Plat';
    final kendaraan = availableKendaraan.firstWhere(
      (k) => k.id == selectedKendaraanId,
      orElse: () => GuardOperasionalFilterKendaraan(id: 0, noPlat: 'Loading'),
    );
    return kendaraan.noPlat;
  }

  // Helper untuk multi choice bottom sheet
  Map<String, bool> get petugasChoiceMap {
    return {
      for (var petugas in availablePetugas)
        petugas.nama: selectedPetugasIds.contains(petugas.id),
    };
  }

  Map<String, bool> get kendaraanChoiceMap {
    return {
      for (var kendaraan in availableKendaraan)
        kendaraan.noPlat: selectedKendaraanId == kendaraan.id,
    };
  }

  // Handler untuk multi choice
  void onPetugasSelected(Map<String, bool> selected) {
    selectedPetugasIds = availablePetugas
        .where((petugas) => selected[petugas.nama] == true)
        .map((p) => p.id)
        .toList();
    notifyListeners();
    loadInitial();
  }

  void onKendaraanSelected(Map<String, bool> selected) {
    final selectedKendaraan = availableKendaraan.firstWhere(
      (kendaraan) => selected[kendaraan.noPlat] == true,
      orElse: () => GuardOperasionalFilterKendaraan(id: 0, noPlat: ''),
    );
    selectedKendaraanId =
        selectedKendaraan.id == 0 ? null : selectedKendaraan.id;
    notifyListeners();
    loadInitial();
  }
}
