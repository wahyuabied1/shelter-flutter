import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_key_loan_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class PinjamanKunciViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardKeyLoanResponse?> keyLoanResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Filter states
  List<int> selectedShift = [];
  List<int> selectedPetugasIds = [];
  int? selectedRuangId;
  String searchQuery = '';

  void init() {
    getKeyLoan();
  }

  Future<bool> getKeyLoan() {
    keyLoanResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardKeyLoanResponse>>(
      future: _guardRepository.getKeyLoan(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
        shift: selectedShift.isEmpty ? null : selectedShift,
        idPetugas: selectedPetugasIds.isEmpty ? null : selectedPetugasIds,
        idRuang: selectedRuangId,
        search: searchQuery.isEmpty ? null : searchQuery,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          keyLoanResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          keyLoanResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getKeyLoan();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getKeyLoan();
  }

  void updateShiftFilter(List<int> shift) {
    selectedShift = shift;
    notifyListeners();
    getKeyLoan();
  }

  void updatePetugasFilter(List<int> petugasIds) {
    selectedPetugasIds = petugasIds;
    notifyListeners();
    getKeyLoan();
  }

  void updateRuangFilter(int? ruangId) {
    selectedRuangId = ruangId;
    notifyListeners();
    getKeyLoan();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
    getKeyLoan();
  }

  void resetFilters() {
    selectedShift = [];
    selectedPetugasIds = [];
    selectedRuangId = null;
    searchQuery = '';
    notifyListeners();
    getKeyLoan();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  GuardKeyLoanResponse? get data => keyLoanResult.dataOrNull;

  bool get isLoading => keyLoanResult.isInitialOrLoading;

  bool get isError => keyLoanResult.isError;

  List<GuardKeyLoan> get keyLoanList => data?.data ?? [];

  int get totalData => keyLoanList.length;

  String get totalDataText => 'Menampilkan $totalData Data';

  // Filter data
  List<int> get availableShifts => data?.filter.shift ?? [];

  List<GuardKeyLoanFilterRuangan> get availableRuangan =>
      data?.filter.ruangan ?? [];

  List<GuardKeyLoanFilterPetugas> get availablePetugas =>
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
        orElse: () => GuardKeyLoanFilterPetugas(id: 0, nama: 'Loading'),
      );
      return petugas.nama;
    }
    return 'Petugas (${selectedPetugasIds.length})';
  }

  String get selectedRuangText {
    if (selectedRuangId == null) return 'Ruang Kunci';
    final ruang = availableRuangan.firstWhere(
      (r) => r.id == selectedRuangId,
      orElse: () => GuardKeyLoanFilterRuangan(id: 0, nama: 'Loading'),
    );
    return ruang.nama;
  }

  // Helper untuk multi choice bottom sheet
  Map<String, bool> get shiftChoiceMap {
    return {
      for (var shift in availableShifts)
        'Shift $shift': selectedShift.contains(shift),
    };
  }

  Map<String, bool> get petugasChoiceMap {
    return {
      for (var petugas in availablePetugas)
        petugas.nama: selectedPetugasIds.contains(petugas.id),
    };
  }

  Map<String, bool> get ruanganChoiceMap {
    return {
      for (var ruang in availableRuangan)
        ruang.nama: selectedRuangId == ruang.id,
    };
  }

  // Handler untuk multi choice
  void onShiftSelected(Map<String, bool> selected) {
    selectedShift = availableShifts
        .where((shift) => selected['Shift $shift'] == true)
        .toList();
    notifyListeners();
    getKeyLoan();
  }

  void onPetugasSelected(Map<String, bool> selected) {
    selectedPetugasIds = availablePetugas
        .where((petugas) => selected[petugas.nama] == true)
        .map((p) => p.id)
        .toList();
    notifyListeners();
    getKeyLoan();
  }

  void onRuanganSelected(Map<String, bool> selected) {
    final selectedRuang = availableRuangan.firstWhere(
      (ruang) => selected[ruang.nama] == true,
      orElse: () => GuardKeyLoanFilterRuangan(id: 0, nama: ''),
    );
    selectedRuangId = selectedRuang.id == 0 ? null : selectedRuang.id;
    notifyListeners();
    getKeyLoan();
  }
}
