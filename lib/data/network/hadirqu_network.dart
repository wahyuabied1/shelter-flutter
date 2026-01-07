import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';

class HadirquNetwork {
  static const _summary = "dashboard/summary";
  static const _paidLeave = "/v2/dashboard/paid-leave";
  static const _sickLeave = "/v2/dashboard/sick-leave";
  static const _overtime = "v2/dashboard/overtime";

  final CoreHttpBuilder _http;
  final CoreHttpRepository _coreHttpRepository;

  HadirquNetwork(this._http,this._coreHttpRepository);

  Future<JsonListResponse<HadirquSummaryResponse>> getSummary({
    required String date,
  }) async{
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    },path: _summary, query: map).get();
    return JsonListResponse(response, HadirquSummaryResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getPaidLeave({
    required String date,
  }) async{
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    },path: _paidLeave, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getSickLeave({
    required String date,
  }) async{
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    },path: _sickLeave, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getOverTime({
    required String date,
  }) async{
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    },path: _overtime, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }
}
