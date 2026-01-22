import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_leave_report_response.g.dart';

@JsonSerializable()
class HadirquLeaveReportResponse {
  @JsonKey(defaultValue: [])
  final List<LeaveReport> data;
  final LeaveFilter filter;
  final String status;

  HadirquLeaveReportResponse({
    required this.data,
    required this.filter,
    required this.status,
  });

  factory HadirquLeaveReportResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquLeaveReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquLeaveReportResponseToJson(this);
}

@JsonSerializable()
class LeaveReport {
  final String status;
  final String waktu;
  final int durasi;
  final String keterangan;
  final LeaveFile file;
  final LeaveUser pemohon;
  final LeaveUser? reviewer;
  final String? review;
  @JsonKey(name: 'potong_jatah')
  final bool potongJatah;
  final LeaveSite site;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'jenis_cuti')
  final JenisCuti jenisCuti;
  @JsonKey(name: 'potong_jatah_cuti')
  final bool potongJatahCuti;

  LeaveReport({
    required this.status,
    required this.waktu,
    required this.durasi,
    required this.keterangan,
    required this.file,
    required this.pemohon,
    this.reviewer,
    this.review,
    required this.potongJatah,
    required this.site,
    required this.createdAt,
    required this.jenisCuti,
    required this.potongJatahCuti,
  });

  factory LeaveReport.fromJson(Map<String, dynamic> json) =>
      _$LeaveReportFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveReportToJson(this);
}

@JsonSerializable()
class LeaveFile {
  final String path;
  final String? ext;

  LeaveFile({
    required this.path,
    this.ext,
  });

  factory LeaveFile.fromJson(Map<String, dynamic> json) =>
      _$LeaveFileFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveFileToJson(this);
}

@JsonSerializable()
class LeaveUser {
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final String? idPegawai;
  final String foto;

  LeaveUser({
    required this.nama,
    this.idPegawai,
    required this.foto,
  });

  factory LeaveUser.fromJson(Map<String, dynamic> json) =>
      _$LeaveUserFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveUserToJson(this);
}

@JsonSerializable()
class LeaveSite {
  @JsonKey(name: 'id_site')
  final int idSite;
  final String nama;

  LeaveSite({
    required this.idSite,
    required this.nama,
  });

  factory LeaveSite.fromJson(Map<String, dynamic> json) =>
      _$LeaveSiteFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveSiteToJson(this);
}

@JsonSerializable()
class JenisCuti {
  final String id;
  final String? text;

  JenisCuti({
    required this.id,
    this.text,
  });

  factory JenisCuti.fromJson(Map<String, dynamic> json) =>
      _$JenisCutiFromJson(json);

  Map<String, dynamic> toJson() => _$JenisCutiToJson(this);
}

@JsonSerializable()
class LeaveFilter {
  @JsonKey(defaultValue: [])
  final List<LeaveStatus> status;
  @JsonKey(defaultValue: [])
  final List<LeaveDepartemen> departemen;

  LeaveFilter({
    required this.status,
    required this.departemen,
  });

  factory LeaveFilter.fromJson(Map<String, dynamic> json) =>
      _$LeaveFilterFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveFilterToJson(this);
}

@JsonSerializable()
class LeaveStatus {
  final int id;
  final String nama;

  LeaveStatus({
    required this.id,
    required this.nama,
  });

  factory LeaveStatus.fromJson(Map<String, dynamic> json) =>
      _$LeaveStatusFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveStatusToJson(this);
}

@JsonSerializable()
class LeaveDepartemen {
  final int id;
  final String nama;
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  LeaveDepartemen({
    required this.id,
    required this.nama,
    required this.totalPegawai,
  });

  factory LeaveDepartemen.fromJson(Map<String, dynamic> json) =>
      _$LeaveDepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveDepartemenToJson(this);
}
