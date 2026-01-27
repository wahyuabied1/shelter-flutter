import 'dart:convert';

import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/guard_summary_response.dart';

import '../model/guard_key_loan_response.dart';
import '../model/guard_phone_response.dart';

class GuardNetwork {
  static const _summary = "rekap";
  static const _keyLoan = "posko/kunci";
  static const _phone = "posko/telepon";

  final CoreHttpBuilder _http;
  final CoreHttpRepository _coreHttpRepository;

  GuardNetwork(this._http, this._coreHttpRepository);

  Future<JsonResponse<GuardSummaryResponse>> getSummary({
    required String tanggalMulai,
    required String tanggalSelesai,
  }) async {
    final map = {
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
    };

    final headers = {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken(),
    };

    final response = await _http
        .guardHttp(
          headers: headers,
          path: _summary,
          query: map,
        )
        .get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = GuardSummaryResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<GuardKeyLoanResponse>> getKeyLoan({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    int? idRuang,
    String? search,
  }) async {
    final map = <String, dynamic>{
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
    };

    // Array params dengan format shift[0]=1&shift[1]=2
    if (shift != null && shift.isNotEmpty) {
      for (int i = 0; i < shift.length; i++) {
        map['shift[$i]'] = shift[i].toString();
      }
    }

    // MULTIPLE id_petugas: Duplicate parameter seperti di contoh URL
    // id_petugas=492&id_petugas=5152
    if (idPetugas != null && idPetugas.isNotEmpty) {
      // Untuk multiple values dengan key yang sama, kita gunakan List
      map['id_petugas'] = idPetugas.map((e) => e.toString()).toList();
    }

    if (idRuang != null) {
      map['id_ruang'] = idRuang.toString();
    }

    if (search != null && search.isNotEmpty) {
      map['search'] = search;
    }

    final headers = {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken(),
    };

    final response = await _http
        .guardHttp(
          headers: headers,
          path: _keyLoan,
          query: map,
        )
        .get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = GuardKeyLoanResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<GuardPhoneResponse>> getPhone({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
  }) async {
    final map = <String, dynamic>{
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
    };

    // Array params dengan format shift[0]=1&shift[1]=2
    if (shift != null && shift.isNotEmpty) {
      for (int i = 0; i < shift.length; i++) {
        map['shift[$i]'] = shift[i].toString();
      }
    }

    // MULTIPLE id_petugas: Duplicate parameter
    // id_petugas=492&id_petugas=5152
    if (idPetugas != null && idPetugas.isNotEmpty) {
      map['id_petugas'] = idPetugas.map((e) => e.toString()).toList();
    }

    if (search != null && search.isNotEmpty) {
      map['search'] = search;
    }

    final headers = {
      'sha': await _coreHttpRepository.getSHA(),
      'salt': await _coreHttpRepository.getToken(),
    };

    final response = await _http
        .guardHttp(
          headers: headers,
          path: _phone,
          query: map,
        )
        .get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = GuardPhoneResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }
}
