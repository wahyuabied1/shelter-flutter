import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_guest_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class GuestViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardGuestResponse?> guestResult = const Result.initial();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  static const int _pageSize = 3;
  int _currentOffset = 0;

  List<GuardGuest> _allGuests = [];

  bool _hasMore = true;
  bool _isLoadingMore = false;

  GuardGuestFilter? _filter;

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _currentOffset = 0;
    _allGuests = [];
    _hasMore = true;
    _filter = null;
    await _fetchGuests(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || guestResult.isInitialOrLoading) return;

    _currentOffset += _pageSize;
    await _fetchGuests(isLoadMore: true);
  }

  Future<bool> _fetchGuests({required bool isLoadMore}) async {
    if (!isLoadMore) {
      guestResult = const Result.loading();
      notifyListeners();
    } else {
      _isLoadingMore = true;
      notifyListeners();
    }

    if (isLoadMore) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }

    return Result.callApi<JsonResponse<GuardGuestResponse>>(
      future: _guardRepository.getGuest(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        shift: selectedShift.isEmpty ? null : selectedShift,
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
        limit: _pageSize,
        offset: _currentOffset,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final response = result.dataOrNull?.data;
          final newItems = response?.data ?? [];

          if (!isLoadMore && response?.filter != null) {
            _filter = response!.filter;
          }

          if (isLoadMore) {
            _allGuests.addAll(newItems);
          } else {
            _allGuests = List.from(newItems);
          }

          _hasMore = newItems.length >= _pageSize;

          guestResult = Result.success(response);
        } else if (result.isError) {
          guestResult = Result.error(result.error);
        }

        _isLoadingMore = false;
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

  void updateShiftFilter(List<int> shift) {
    selectedShift = shift;
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
    selectedShift = [];
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

  bool get isLoading => guestResult.isInitialOrLoading;

  bool get isError => guestResult.isError;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMore => _hasMore;

  List<GuardGuest> get guestList => _allGuests;

  int get totalData => _allGuests.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => _filter?.shift ?? [];

  List<GuardGuestFilterPetugas> get availablePetugas => _filter?.petugas ?? [];

  // Text untuk filter buttons
  String get selectedShiftText {
    if (selectedShift.isEmpty) return 'Shift';
    if (selectedShift.length == 1) return 'Shift ${selectedShift.first}';
    return 'Shift (${selectedShift.length})';
  }

  String get selectedPetugasText {
    if (selectedPetugasIds.isEmpty) return 'Petugas';
    if (selectedPetugasIds.length == 1) {
      final petugas = availablePetugas.firstWhere(
        (p) => p.id == selectedPetugasIds.first,
        orElse: () => GuardGuestFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
