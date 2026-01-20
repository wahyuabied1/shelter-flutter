import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/hadirqu_summary_response.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/data/network/hadirqu_network.dart';

import '../model/hadirqu_presence_detail_response.dart';
import '../model/hadirqu_presence_list_response.dart';
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

  Future<JsonResponse<HadirquPresenceListResponse>> getPresenceList({
    String? tanggalMulai,
    String? tanggalSelesai,
    List<int>? idDepartemen,
    List<String>? jabatan,
    int? filterKehadiran,
    String? filterKehadiranPersamaan,
    int? filterKehadiranNilai,
  }) async {
    return _hadirquNetwork.getPresenceList(
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      idDepartemen: idDepartemen,
      jabatan: jabatan,
      filterKehadiran: filterKehadiran,
      filterKehadiranPersamaan: filterKehadiranPersamaan,
      filterKehadiranNilai: filterKehadiranNilai,
    );
  }

  Future<JsonResponse<HadirquPresenceListResponse>> getLogPresenceList({
    String? tanggalMulai,
    String? tanggalSelesai,
    List<int>? idDepartemen,
    List<String>? jabatan,
    int? filterKehadiran,
    String? filterKehadiranPersamaan,
    int? filterKehadiranNilai,
  }) async {
    return _hadirquNetwork.getPresenceLogList(
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      idDepartemen: idDepartemen,
      jabatan: jabatan,
      filterKehadiran: filterKehadiran,
      filterKehadiranPersamaan: filterKehadiranPersamaan,
      filterKehadiranNilai: filterKehadiranNilai,
    );
  }

  Future<JsonResponse<HadirquPresenceDetailResponse>> getPresenceDetail({
    required String tanggalMulai,
    required String tanggalSelesai,
    required int idKaryawan,
  }) async {
    return _hadirquNetwork.getPresenceDetail(
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      idKaryawan: idKaryawan,
    );
  }

  Future<JsonResponse<HadirquPresenceDetailResponse>> getPresenceLogDetail({
    required String tanggalMulai,
    required String tanggalSelesai,
    required int idKaryawan,
  }) async {
    return _hadirquNetwork.getPresenceLogDetail(
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      idKaryawan: idKaryawan,
    );
  }
}
