import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_transporter_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class TransporterViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardTransporterResponse?> transporterResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  // Pagination states
  static const int _pageSize = 10;
  int _limit = 10;
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<GuardTransporter> _allTransporters = [];

  // Filter data (dari response pertama)
  GuardTransporterFilter? _filter;

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _limit = _pageSize;
    _offset = 0;
    _allTransporters = [];
    _hasMore = true;
    _filter = null;
    await _fetchTransporter(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || transporterResult.isInitialOrLoading)
      return;
    _offset = _limit;
    _limit += _pageSize;
    await _fetchTransporter(isLoadMore: true);
  }

  Future<bool> _fetchTransporter({required bool isLoadMore}) {
    if (!isLoadMore) {
      transporterResult = const Result.loading();
      notifyListeners();
    } else {
      _isLoadingMore = true;
      notifyListeners();
    }

    return Result.callApi<JsonResponse<GuardTransporterResponse>>(
      future: _guardRepository.getTransporter(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
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
            _allTransporters.addAll(newItems);
          } else {
            _allTransporters = List.from(newItems);
          }

          _hasMore = newItems.length >= _pageSize;

          transporterResult = Result.success(response);
        } else if (result.isError) {
          transporterResult = Result.error(result.error);
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

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    loadInitial();
  }

  void resetFilters() {
    selectedPetugasIds = [];
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

  bool get isLoading => transporterResult.isInitialOrLoading;

  bool get isError => transporterResult.isError;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMore => _hasMore;

  List<GuardTransporter> get transporterList => _allTransporters;

  int get totalData => _allTransporters.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<GuardTransporterFilterPetugas> get availablePetugas =>
      _filter?.petugas ?? [];

  // Text untuk filter button
  String get selectedPetugasText {
    if (selectedPetugasIds.isEmpty) return 'Petugas';
    if (selectedPetugasIds.length == 1) {
      final petugas = availablePetugas.firstWhere(
        (p) => p.id == selectedPetugasIds.first,
        orElse: () => GuardTransporterFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
