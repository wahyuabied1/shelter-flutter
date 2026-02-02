import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_project_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class ProjectViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardProjectResponse?> projectResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states (tidak ada shift filter di proyek)
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  // Pagination states
  int _offset = 0;
  bool _hasMore = true;
  bool isLoadMoreInProgress = false;
  List<GuardProject> _allProjects = [];

  void init() {
    loadInitial();
  }

  Future<void> loadInitial() async {
    _offset = 0;
    _allProjects = [];
    _hasMore = true;
    await _fetchProject(isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (_hasMore) {
      if (isLoadMoreInProgress) {
        return Future(() => []);
      } else {
        isLoadMoreInProgress = true;
        await _fetchProject(isLoadMore: true);
      }
    }
  }

  Future<bool> _fetchProject({required bool isLoadMore}) {
    if (!isLoadMore) {
      projectResult = const Result.loading();
      notifyListeners();
    }

    return Result.callApi<JsonResponse<GuardProjectResponse>>(
      future: _guardRepository.getProject(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
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
            _allProjects.addAll(newItems);
          } else {
            _allProjects = List.from(newItems);
          }

          _hasMore = newItems.isNotEmpty;
          _offset = _allProjects.length;

          projectResult = Result.success(response);
        } else if (result.isError) {
          projectResult = Result.error(result.error);
        }
        isLoadMoreInProgress = false;
        notifyListeners();
      },
    );
  }

  // Kept for backward compatibility
  Future<bool> getProject() async {
    await loadInitial();
    return true;
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

  GuardProjectResponse? get data => projectResult.dataOrNull;

  bool get isLoading => projectResult.isInitialOrLoading;

  bool get isError => projectResult.isError;

  bool get hasMore => _hasMore;

  List<GuardProject> get projectList => _allProjects;

  int get totalData => _allProjects.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<GuardProjectFilterPetugas> get availablePetugas =>
      data?.filter.petugas ?? [];

  // Text untuk filter button
  String get selectedPetugasText {
    if (selectedPetugasIds.isEmpty) return 'Petugas';
    if (selectedPetugasIds.length == 1) {
      final petugas = availablePetugas.firstWhere(
        (p) => p.id == selectedPetugasIds.first,
        orElse: () => GuardProjectFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
