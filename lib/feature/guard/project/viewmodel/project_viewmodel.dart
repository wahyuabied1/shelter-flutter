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

  void init() {
    getProject();
  }

  Future<bool> getProject() {
    projectResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardProjectResponse>>(
      future: _guardRepository.getProject(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          projectResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          projectResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getProject();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getProject();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    getProject();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    getProject();
  }

  void resetFilters() {
    selectedPetugasIds = [];
    searchQuery = '';
    notifyListeners();
    getProject();
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

  List<GuardProject> get projectList => data?.data ?? [];

  int get totalData => projectList.length;

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
