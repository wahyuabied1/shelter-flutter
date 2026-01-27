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

  // Filter states (ada shift dan petugas)
  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  void init() {
    getNews();
  }

  Future<bool> getNews() {
    newsResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardNewsResponse>>(
      future: _guardRepository.getNews(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        shift: selectedShift.isEmpty ? null : selectedShift,
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          newsResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          newsResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getNews();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getNews();
  }

  void updateShiftFilter(List<int> shift) {
    selectedShift = shift;
    notifyListeners();
    getNews();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    getNews();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    getNews();
  }

  void resetFilters() {
    selectedShift = [];
    selectedPetugasIds = [];
    searchQuery = '';
    notifyListeners();
    getNews();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  GuardNewsResponse? get data => newsResult.dataOrNull;

  bool get isLoading => newsResult.isInitialOrLoading;

  bool get isError => newsResult.isError;

  List<GuardNews> get newsList => data?.data ?? [];

  int get totalData => newsList.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => data?.filter.shift ?? [];

  List<GuardNewsFilterPetugas> get availablePetugas =>
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
        orElse: () => GuardNewsFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
