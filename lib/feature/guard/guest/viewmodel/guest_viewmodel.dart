import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_guest_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class GuestViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardGuestResponse?> guestResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  String searchQuery = '';

  void init() {
    getGuest();
  }

  Future<bool> getGuest() {
    guestResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardGuestResponse>>(
      future: _guardRepository.getGuest(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        shift: selectedShift.isEmpty ? null : selectedShift,
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        search: searchQuery.isEmpty ? null : searchQuery,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          guestResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          guestResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getGuest();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getGuest();
  }

  void updateShiftFilter(List<int> shift) {
    selectedShift = shift;
    notifyListeners();
    getGuest();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    getGuest();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    getGuest();
  }

  void resetFilters() {
    selectedShift = [];
    selectedPetugasIds = [];
    searchQuery = '';
    notifyListeners();
    getGuest();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  GuardGuestResponse? get data => guestResult.dataOrNull;

  bool get isLoading => guestResult.isInitialOrLoading;

  bool get isError => guestResult.isError;

  List<GuardGuest> get guestList => data?.data ?? [];

  int get totalData => guestList.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => data?.filter.shift ?? [];

  List<GuardGuestFilterPetugas> get availablePetugas =>
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
        orElse: () => GuardGuestFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }
}
