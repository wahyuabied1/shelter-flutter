import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class HadirquHomeViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<HadirquSummaryResponse?> summaryResult = const Result.initial();

  void init() {
    getSummary();
  }

  Future<bool> getSummary() {
    return Result.callApi<JsonResponse<HadirquSummaryResponse>>(
      future: _hadirquRepository.getSummary(
        date: DateTime.now().yyyyMMdd('-'),
      ),
      onResult: (result) {
        if (result.isSuccess) {
          summaryResult = Result.success(result.dataOrNull?.data);
        } else if (result.isError) {
          summaryResult = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

}
