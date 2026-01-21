import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_employee_list_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class ListEmployeeViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquEmployeeListResponse?> employeeResult = const Result.initial();

  // Filter states
  List<int> selectedDepartemenIds = [];
  List<String> selectedJabatan = [];
  List<int> selectedGrupIds = [];
  String searchQuery = '';

  void init() {
    getEmployeeList();
  }

  Future<bool> getEmployeeList() {
    employeeResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<HadirquEmployeeListResponse>>(
      future: _hadirquRepository.getEmployeeList(
        idDepartemen:
            selectedDepartemenIds.isEmpty ? null : selectedDepartemenIds,
        jabatan: selectedJabatan.isEmpty ? null : selectedJabatan,
        grupId: selectedGrupIds.isEmpty ? null : selectedGrupIds,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          employeeResult = Result.success(result.dataOrNull?.data);
        } else if (result.isError) {
          employeeResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateDepartemenFilter(List<int> departemenIds) {
    selectedDepartemenIds = departemenIds;
    notifyListeners();
    getEmployeeList();
  }

  void updateJabatanFilter(List<String> jabatan) {
    selectedJabatan = jabatan;
    notifyListeners();
    getEmployeeList();
  }

  void updateGrupFilter(List<int> grupIds) {
    selectedGrupIds = grupIds;
    notifyListeners();
    getEmployeeList();
  }

  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    notifyListeners();
  }

  void resetFilters() {
    selectedDepartemenIds = [];
    selectedJabatan = [];
    selectedGrupIds = [];
    searchQuery = '';
    notifyListeners();
    getEmployeeList();
  }

  // =======================
  // Helper untuk UI
  // =======================

  HadirquEmployeeListResponse? get data => employeeResult.dataOrNull;

  bool get isLoading => employeeResult.isInitialOrLoading;

  bool get isError => employeeResult.isError;

  List<Employee> get employeeList {
    final list = data?.data ?? [];

    if (searchQuery.isEmpty) return list;

    return list.where((employee) {
      return employee.nama.toLowerCase().contains(searchQuery) ||
          (employee.jabatan?.toLowerCase().contains(searchQuery) ?? false) ||
          (employee.namaDepartemen?.toLowerCase().contains(searchQuery) ??
              false) ||
          (employee.idPegawai?.toString().contains(searchQuery) ?? false);
    }).toList();
  }

  int get totalEmployees => employeeList.length;

  // Filter data
  List<EmployeeDepartemen> get availableDepartemen =>
      data?.filter.departemen ?? [];

  List<String> get availableJabatan => data?.filter.jabatan ?? [];

  List<EmployeeGrup> get availableGrup => data?.filter.grup ?? [];

  // Text untuk filter buttons
  String get selectedDepartemenText {
    if (selectedDepartemenIds.isEmpty) return 'Departemen';
    if (selectedDepartemenIds.length == 1) {
      final dept = availableDepartemen.firstWhere(
        (d) => d.id == selectedDepartemenIds.first,
        orElse: () =>
            EmployeeDepartemen(id: 0, nama: 'Loading', totalPegawai: 0),
      );
      return dept.nama;
    }
    return 'Departemen (${selectedDepartemenIds.length})';
  }

  String get selectedJabatanText {
    if (selectedJabatan.isEmpty) return 'Jabatan';
    if (selectedJabatan.length == 1) return selectedJabatan.first;
    return 'Jabatan (${selectedJabatan.length})';
  }

  String get selectedGrupText {
    if (selectedGrupIds.isEmpty) return 'Group/Template';
    if (selectedGrupIds.length == 1) {
      final grup = availableGrup.firstWhere(
        (g) => g.id == selectedGrupIds.first,
        orElse: () => EmployeeGrup(id: 0, text: 'Loading'),
      );
      return grup.text;
    }
    return 'Grup (${selectedGrupIds.length})';
  }
}
