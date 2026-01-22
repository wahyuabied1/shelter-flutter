import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_overtime_report_response.g.dart';

@JsonSerializable()
class HadirquOvertimeReportResponse {
  @JsonKey(defaultValue: [])
  final List<OvertimeReport> data;
  final OvertimeFilter filter;
  final String status;

  HadirquOvertimeReportResponse({
    required this.data,
    required this.filter,
    required this.status,
  });

  factory HadirquOvertimeReportResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquOvertimeReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquOvertimeReportResponseToJson(this);
}

@JsonSerializable()
class OvertimeReport {
  @JsonKey(name: 'jumlah_lembur')
  final int jumlahLembur;
  final String durasi;
  final OvertimeUser pemohon;

  OvertimeReport({
    required this.jumlahLembur,
    required this.durasi,
    required this.pemohon,
  });

  factory OvertimeReport.fromJson(Map<String, dynamic> json) =>
      _$OvertimeReportFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeReportToJson(this);
}

@JsonSerializable()
class OvertimeUser {
  final String nama;
  final String departemen;
  @JsonKey(name: 'id_pegawai')
  final String idPegawai;
  final String foto;

  OvertimeUser({
    required this.nama,
    required this.departemen,
    required this.idPegawai,
    required this.foto,
  });

  factory OvertimeUser.fromJson(Map<String, dynamic> json) =>
      _$OvertimeUserFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeUserToJson(this);
}

@JsonSerializable()
class OvertimeFilter {
  @JsonKey(defaultValue: [])
  final List<OvertimeDepartemen> departemen;
  @JsonKey(defaultValue: [])
  final List<OvertimeStatus> status;

  OvertimeFilter({
    required this.departemen,
    required this.status,
  });

  factory OvertimeFilter.fromJson(Map<String, dynamic> json) =>
      _$OvertimeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeFilterToJson(this);
}

@JsonSerializable()
class OvertimeDepartemen {
  final int id;
  final String nama;
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  OvertimeDepartemen({
    required this.id,
    required this.nama,
    required this.totalPegawai,
  });

  factory OvertimeDepartemen.fromJson(Map<String, dynamic> json) =>
      _$OvertimeDepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeDepartemenToJson(this);
}

@JsonSerializable()
class OvertimeStatus {
  final int id;
  final String nama;

  OvertimeStatus({
    required this.id,
    required this.nama,
  });

  factory OvertimeStatus.fromJson(Map<String, dynamic> json) =>
      _$OvertimeStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeStatusToJson(this);
}
