import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_news_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class NewsViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardNewsResponse?> newsResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  // Pagination states
  int _offset = 0;
  bool _hasMore = true;
  bool isLoadMoreInProgress = false;
  List<GuardNews> _allNews = [];

  // Filter data (dari response pertama)
  GuardNewsFilter? _filter;

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _offset = 0;
    _allNews = [];
    _hasMore = true;
    _filter = null;
    await _fetchNews(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if(_hasMore){
      if(isLoadMoreInProgress){
        return Future(() => []);
      }else{
        isLoadMoreInProgress = true;
        await _fetchNews(isLoadMore: true);
      }
    }
  }

  Future<bool> _fetchNews({required bool isLoadMore}) {
    if (!isLoadMore) {
      newsResult = const Result.loading();
      notifyListeners();
    }

    return Result.callApi<JsonResponse<GuardNewsResponse>>(
      future: _guardRepository.getNews(
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

          // Simpan filter dari response pertama
          if (!isLoadMore && response?.filter != null) {
            _filter = response!.filter;
          }

          if (isLoadMore) {
            _allNews.addAll(newItems);
          } else {
            _allNews = List.from(newItems);
          }

          _hasMore = newItems.isNotEmpty;
          _offset = _allNews.length;

          newsResult = Result.success(response);
        } else if (result.isError) {
          newsResult = Result.error(result.error);
        }
        isLoadMoreInProgress = false;
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

  bool get isLoading => newsResult.isInitialOrLoading;

  bool get isError => newsResult.isError;

  bool get hasMore => _hasMore;

  List<GuardNews> get newsList => _allNews;

  int get totalData => _allNews.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => _filter?.shift ?? [];

  List<GuardNewsFilterPetugas> get availablePetugas => _filter?.petugas ?? [];

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
        orElse: () => GuardNewsFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
