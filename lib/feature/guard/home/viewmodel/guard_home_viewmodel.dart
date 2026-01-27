import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/guard_summary_response.dart';
import 'package:shelter_super_app/data/repository/guard_repository.dart';

class GuardHomeViewmodel extends ABaseChangeNotifier {
  final _guardRepository = serviceLocator.get<GuardRepository>();

  Result<GuardSummaryResponse?> summaryResult = const Result.initial();

  // Date range states
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  void init() {
    getSummary();
  }

  Future<bool> getSummary() {
    summaryResult = const Result.loading();
    notifyListeners();

    return Result.callApi<JsonResponse<GuardSummaryResponse>>(
      future: _guardRepository.getSummary(
        tanggalMulai: _formatDate(startDate),
        tanggalSelesai: _formatDate(endDate),
      ),
      onResult: (result) {
        if (result.isSuccess) {
          final jsonResponse = result.dataOrNull;

          summaryResult = Result.success(
            jsonResponse?.data,
          );
        } else if (result.isError) {
          summaryResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    getSummary();
  }

  void updateEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    getSummary();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // =======================
  // Helper untuk UI
  // =======================

  GuardSummaryResponse? get data => summaryResult.dataOrNull;

  bool get isLoading => summaryResult.isInitialOrLoading;

  bool get isError => summaryResult.isError;

  String get totalPetugas => data?.data.petugas.toString() ?? '0';

  String get totalAbsensi => data?.data.absensi.toString() ?? '0';

  String get totalChecklist => data?.data.checklist.toString() ?? '0';

  String get totalBerita => data?.data.berita.toString() ?? '0';
}
