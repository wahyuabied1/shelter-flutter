import 'dart:convert';

import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/guard_summary_response.dart';

class GuardNetwork {
  static const _summary = "v1/rekap";

  final CoreHttpBuilder _http;
  final CoreHttpRepository _coreHttpRepository;

  GuardNetwork(this._http, this._coreHttpRepository);

  Future<JsonResponse<GuardSummaryResponse>> getSummary({
    required String tanggalMulai,
    required String tanggalSelesai,
  }) async {
    final map = <String, dynamic>{
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
    };

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _summary,
      query: map,
    ).get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = GuardSummaryResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }
}
