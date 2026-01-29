import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/guard_summary_response.dart';
import 'package:shelter_super_app/data/network/guard_network.dart';

import '../model/guard_guest_response.dart';
import '../model/guard_journal_response.dart';
import '../model/guard_key_loan_response.dart';
import '../model/guard_mail_response.dart';
import '../model/guard_news_response.dart';
import '../model/guard_phone_response.dart';
import '../model/guard_project_response.dart';
import '../model/guard_transporter_response.dart';

class GuardRepository {
  final GuardNetwork _guardNetwork;

  GuardRepository(this._guardNetwork);

  Future<JsonResponse<GuardSummaryResponse>> getSummary({
    required String tanggalMulai,
    required String tanggalSelesai,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getSummary(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardKeyLoanResponse>> getKeyLoan({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    int? idRuang,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getKeyLoan(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        idRuang: idRuang,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardPhoneResponse>> getPhone({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getPhone(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardGuestResponse>> getGuest({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
    int limit = 3,
    int offset = 0,
  }) async {
    return _guardNetwork.getGuest(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardProjectResponse>> getProject({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getProject(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardTransporterResponse>> getTransporter({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getTransporter(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardMailResponse>> getMail({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getMail(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardJournalResponse>> getJournal({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getJournal(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }

  Future<JsonResponse<GuardNewsResponse>> getNews({
    required String tanggalMulai,
    required String tanggalSelesai,
    List<int>? shift,
    List<int>? idPetugas,
    String? search,
    int limit = 10,
    int offset = 0,
  }) async {
    return _guardNetwork.getNews(
        tanggalMulai: tanggalMulai,
        tanggalSelesai: tanggalSelesai,
        shift: shift,
        idPetugas: idPetugas,
        search: search,
        limit: limit,
        offset: offset);
  }
}
