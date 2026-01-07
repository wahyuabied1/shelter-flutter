import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/data/repository/hadirqu_repository.dart';

class TimeOffViewmodel extends ABaseChangeNotifier {
  final _hadirquRepository = serviceLocator.get<HadirquRepository>();

  Result<List<TimeOffResponse>> timeOffResult = const Result.initial();
  Result<List<TimeOffResponse>> sickLeaveOff = const Result.initial();
  Result<List<TimeOffResponse>> overtime = const Result.initial();

  Future<bool> getPaidLeave() {
      return Result.callApi<JsonListResponse<TimeOffResponse>>(
        future: _hadirquRepository.getPaidLeave(
          date: DateTime.now().yyyyMMdd('-'),
        ),
        onResult: (result) {
          if (result.isSuccess) {
            timeOffResult = Result.success(result.dataOrNull?.data?.cast() ?? []);
          } else if (result.isError) {
            timeOffResult = Result.error(result.error);
          }
          notifyListeners();
        },
      );
  }

  Future<bool> getSickLeave() {
    return Result.callApi<JsonListResponse<TimeOffResponse>>(
      future: _hadirquRepository.getSickLeave(
        date: DateTime.now().yyyyMMdd('-'),
      ),
      onResult: (result) {
        if (result.isSuccess) {
          sickLeaveOff = Result.success(result.dataOrNull?.data?.cast() ?? []);
        } else if (result.isError) {
          sickLeaveOff = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }

  Future<bool> getOvertime() {
    return Result.callApi<JsonListResponse<TimeOffResponse>>(
      future: _hadirquRepository.getOverTime(
        date: DateTime.now().yyyyMMdd('-'),
      ),
      onResult: (result) {
        if (result.isSuccess) {
          overtime = Result.success(result.dataOrNull?.data?.cast() ?? []);
        } else if (result.isError) {
          overtime = Result.error(result.error);
        }
        notifyListeners();
      },
    );
  }
}