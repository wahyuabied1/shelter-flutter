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

  // Filter states (tidak ada shift filter di transporter)
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  void init() {
    getTransporter();
  }

  Future<bool> getTransporter() {
    transporterResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardTransporterResponse>>(
      future: _guardRepository.getTransporter(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          transporterResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          transporterResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getTransporter();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getTransporter();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    getTransporter();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    getTransporter();
  }

  void resetFilters() {
    selectedPetugasIds = [];
    searchQuery = '';
    notifyListeners();
    getTransporter();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  GuardTransporterResponse? get data => transporterResult.dataOrNull;

  bool get isLoading => transporterResult.isInitialOrLoading;

  bool get isError => transporterResult.isError;

  List<GuardTransporter> get transporterList => data?.data ?? [];

  int get totalData => transporterList.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<GuardTransporterFilterPetugas> get availablePetugas =>
      data?.filter.petugas ?? [];

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
