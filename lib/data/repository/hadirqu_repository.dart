import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/data/network/hadirqu_network.dart';

import '../model/hadirqu_report_response.dart';

class HadirquRepository {
  final HadirquNetwork _hadirquNetwork;

  HadirquRepository(this._hadirquNetwork);

  Future<JsonResponse<HadirquSummaryResponse>> getSummary(
      {required String date}) async {
    return _hadirquNetwork.getSummary(date: date);
  }

  Future<JsonListResponse<TimeOffResponse>> getPaidLeave(
      {required String date}) async {
    return _hadirquNetwork.getPaidLeave(date: date);
  }

  Future<JsonListResponse<TimeOffResponse>> getSickLeave(
      {required String date}) async {
    return _hadirquNetwork.getSickLeave(date: date);
  }

  Future<JsonListResponse<TimeOffResponse>> getOverTime(
      {required String date}) async {
    return _hadirquNetwork.getOverTime(date: date);
  }

  Future<JsonResponse<HadirquReportResponse>> getReport({
    required String date,
    List<int>? departemenIds,
  }) async {
    return _hadirquNetwork.getReport(
      date: date,
      departemenIds: departemenIds,
    );
  }
}
