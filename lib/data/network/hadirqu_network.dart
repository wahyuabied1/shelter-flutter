import 'dart:convert';

import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_report_response.dart';

class HadirquNetwork {
  static const _summary = "/v2/dashboard/summary";
  static const _paidLeave = "/v2/dashboard/paid-leave";
  static const _sickLeave = "/v2/dashboard/sick-leave";
  static const _overtime = "v2/dashboard/overtime";
  static const _report = "v2/attedance/summary";

  final CoreHttpBuilder _http;
  final CoreHttpRepository _coreHttpRepository;

  HadirquNetwork(this._http, this._coreHttpRepository);

  Future<JsonResponse<HadirquSummaryResponse>> getSummary({
    required String date,
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    }, path: _summary, query: map).get();
    return JsonResponse(response, HadirquSummaryResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getPaidLeave({
    required String date,
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    }, path: _paidLeave, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getSickLeave({
    required String date,
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    }, path: _sickLeave, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }

  Future<JsonListResponse<TimeOffResponse>> getOverTime({
    required String date,
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    final response = await _http.hadirkuHttp(headers: {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken()
    }, path: _overtime, query: map).get();
    return JsonListResponse(response, TimeOffResponse.fromJson);
  }

  Future<JsonResponse<HadirquReportResponse>> getReport({
    required String date,
    List<int>? departemenIds, // Tambah parameter untuk filter departemen
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    if (departemenIds != null && departemenIds.isNotEmpty) {
      map['id_departemen'] = departemenIds.join(',');
    }

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _report,
      query: map,
    ).get();

    // Manual parse
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquReportResponse.fromJson(json);

    return JsonResponse(response, (_) => data);
  }
}
