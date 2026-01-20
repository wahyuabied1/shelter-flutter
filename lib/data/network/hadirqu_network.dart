import 'dart:convert';

import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_report_response.dart';

import '../model/hadirqu_attendance_detail_response.dart';
import '../model/hadirqu_presence_detail_response.dart';
import '../model/hadirqu_presence_list_response.dart';

class HadirquNetwork {
  static const _summary = "/v2/dashboard/summary";
  static const _paidLeave = "/v2/dashboard/paid-leave";
  static const _sickLeave = "/v2/dashboard/sick-leave";
  static const _overtime = "v2/dashboard/overtime";
  static const _report = "v2/attedance/summary";
  static const _attendanceDetail = "/open-api/v2/attedance/detail";
  static const _presenceList = "v2/attedance/presence/list";
  static const _presenceLogList = "v2/attedance/log-presence/list";
  static const _presenceDetail = "v2/attedance/presence/detail";
  static const _presenceLogDetail = "v2/attedance/log-presence/detail";

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
    List<int>? departemenIds,
  }) async {
    final map = <String, dynamic>{};
    map['tanggal'] = date;

    if (departemenIds != null && departemenIds.isNotEmpty) {
      map['id_departemen'] = departemenIds.map((e) => e.toString()).toList();
    }

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _report,
      query: map,
    ).get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquReportResponse.fromJson(json);

    return JsonResponse(response, (_) => data);
  }

  Future<JsonResponse<HadirquAttendanceDetailResponse>> getAttendanceDetail({
    required int kehadiran, // 1 = hadir, 0 = tidak hadir
    String? tanggal,
    List<int>? idDepartemen,
    List<String>? jabatan,
    String? karyawan,
  }) async {
    final map = <String, dynamic>{
      'kehadiran': kehadiran.toString(),
    };

    if (tanggal != null) {
      map['tanggal'] = tanggal;
    }

    if (idDepartemen != null && idDepartemen.isNotEmpty) {
      map['id_departemen'] = idDepartemen.join(',');
    }

    if (jabatan != null && jabatan.isNotEmpty) {
      map['jabatan'] = jabatan.join(',');
    }

    if (karyawan != null && karyawan.isNotEmpty) {
      map['karyawan'] = karyawan;
    }

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _attendanceDetail,
      query: map,
    ).get();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquAttendanceDetailResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<HadirquPresenceListResponse>> getPresenceList({
    String? tanggalMulai,
    String? tanggalSelesai,
    List<int>? idDepartemen,
    List<String>? jabatan,
    int? filterKehadiran,
    String? filterKehadiranPersamaan,
    int? filterKehadiranNilai,
  }) async {
    final map = <String, dynamic>{};

    if (tanggalMulai != null) {
      map['tanggal_mulai'] = tanggalMulai;
    }

    if (tanggalSelesai != null) {
      map['tanggal_selesai'] = tanggalSelesai;
    }

    // Untuk multi departemen: id_departemen[]=1&id_departemen[]=199
    if (idDepartemen != null && idDepartemen.isNotEmpty) {
      for (int i = 0; i < idDepartemen.length; i++) {
        map['id_departemen[$i]'] = idDepartemen[i].toString();
      }
    }

    // Untuk multi jabatan: jabatan[]=tester_akfisa&jabatan[]=Jabatan
    if (jabatan != null && jabatan.isNotEmpty) {
      for (int i = 0; i < jabatan.length; i++) {
        map['jabatan[$i]'] = jabatan[i];
      }
    }

    if (filterKehadiran != null) {
      map['filter_kehadiran'] = filterKehadiran.toString();
    }

    if (filterKehadiranPersamaan != null) {
      map['filter_kehadiran_persamaan'] = filterKehadiranPersamaan;
    }

    if (filterKehadiranNilai != null) {
      map['filter_kehadiran_nilai'] = filterKehadiranNilai.toString();
    }

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _presenceList,
      query: map,
    ).get();

    // Manual parse
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquPresenceListResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<HadirquPresenceListResponse>> getPresenceLogList({
    String? tanggalMulai,
    String? tanggalSelesai,
    List<int>? idDepartemen,
    List<String>? jabatan,
    int? filterKehadiran,
    String? filterKehadiranPersamaan,
    int? filterKehadiranNilai,
  }) async {
    final map = <String, dynamic>{};

    if (tanggalMulai != null) {
      map['tanggal_mulai'] = tanggalMulai;
    }

    if (tanggalSelesai != null) {
      map['tanggal_selesai'] = tanggalSelesai;
    }

    // Untuk multi departemen: id_departemen[]=1&id_departemen[]=199
    if (idDepartemen != null && idDepartemen.isNotEmpty) {
      for (int i = 0; i < idDepartemen.length; i++) {
        map['id_departemen[$i]'] = idDepartemen[i].toString();
      }
    }

    // Untuk multi jabatan: jabatan[]=tester_akfisa&jabatan[]=Jabatan
    if (jabatan != null && jabatan.isNotEmpty) {
      for (int i = 0; i < jabatan.length; i++) {
        map['jabatan[$i]'] = jabatan[i];
      }
    }

    if (filterKehadiran != null) {
      map['filter_kehadiran'] = filterKehadiran.toString();
    }

    if (filterKehadiranPersamaan != null) {
      map['filter_kehadiran_persamaan'] = filterKehadiranPersamaan;
    }

    if (filterKehadiranNilai != null) {
      map['filter_kehadiran_nilai'] = filterKehadiranNilai.toString();
    }

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _presenceLogList,
      query: map,
    ).get();

    // Manual parse
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquPresenceListResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<HadirquPresenceDetailResponse>> getPresenceDetail({
    required String tanggalMulai,
    required String tanggalSelesai,
    required int idKaryawan,
  }) async {
    final map = <String, dynamic>{
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'id_karyawan': idKaryawan.toString(),
    };

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _presenceDetail,
      query: map,
    ).get();

    // Manual parse
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquPresenceDetailResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }

  Future<JsonResponse<HadirquPresenceDetailResponse>> getPresenceLogDetail({
    required String tanggalMulai,
    required String tanggalSelesai,
    required int idKaryawan,
  }) async {
    final map = <String, dynamic>{
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'id_karyawan': idKaryawan.toString(),
    };

    final response = await _http.hadirkuHttp(
      headers: {
        'sha': await _coreHttpRepository.getSHA(),
        'salt': await _coreHttpRepository.getToken()
      },
      path: _presenceLogDetail,
      query: map,
    ).get();

    // Manual parse
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = HadirquPresenceDetailResponse.fromJson(json);

    return JsonResponse(
      response,
      (_) => data,
      source: () => json,
    );
  }
}
