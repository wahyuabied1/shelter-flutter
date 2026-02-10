import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_mail_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class MailViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardMailResponse?> mailResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states (ada shift dan petugas)
  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  // Pagination states
  int _offset = 0;
  bool _hasMore = true;
  bool isLoadMoreInProgress = false;
  List<GuardMail> _allMails = [];

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _offset = 0;
    _allMails = [];
    _hasMore = true;
    await _fetchMail(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_hasMore) {
      if (isLoadMoreInProgress) {
        return Future(() => []);
      } else {
        isLoadMoreInProgress = true;
        await _fetchMail(isLoadMore: true);
      }
    }
  }

  Future<bool> _fetchMail({required bool isLoadMore}) {
    if (!isLoadMore) {
      mailResult = const Result.loading();
      notifyListeners();
    }

    return Result.callApi<JsonResponse<GuardMailResponse>>(
      future: _guardRepository.getMail(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        shift: selectedShift.isEmpty ? null : selectedShift,
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
        limit: 10,
        offset: _offset,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final response = result.dataOrNull?.data;
          final newItems = response?.data ?? [];

          if (isLoadMore) {
            _allMails.addAll(newItems);
          } else {
            _allMails = List.from(newItems);
          }

          _hasMore = newItems.isNotEmpty;
          _offset = _allMails.length;

          mailResult = Result.success(response);
        } else if (result.isError) {
          mailResult = Result.error(result.error);
        }
        isLoadMoreInProgress = false;
        notifyListeners();
      },
    );
  }

  // Kept for backward compatibility
  Future<bool> getMail() async {
    await loadInitial();
    return true;
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

  GuardMailResponse? get data => mailResult.dataOrNull;

  bool get isLoading => mailResult.isInitialOrLoading;

  bool get isError => mailResult.isError;

  bool get hasMore => _hasMore;

  List<GuardMail> get mailList => _allMails;

  int get totalData => _allMails.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => data?.filter.shift ?? [];

  List<GuardMailFilterPetugas> get availablePetugas =>
      data?.filter.petugas ?? [];

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
        orElse: () => GuardMailFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
