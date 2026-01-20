import 'package:json_annotation/json_annotation.dart';

import 'hadirqu_departement_filter_response.dart';

part 'hadirqu_attendance_detail_response.g.dart';

@JsonSerializable()
class HadirquAttendanceDetailResponse {
  final List<AttendanceDetail> data;
  final AttendanceDetailFilter filter;
  final String status;

  HadirquAttendanceDetailResponse({
    required this.data,
    required this.filter,
    required this.status,
  });

  factory HadirquAttendanceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquAttendanceDetailResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$HadirquAttendanceDetailResponseToJson(this);
}

@JsonSerializable()
class AttendanceDetail {
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final String idPegawai;
  final String foto;
  final String jabatan;
  @JsonKey(name: 'nama_site')
  final String namaSite;
  @JsonKey(name: 'jadwal_jam_mulai')
  final String? jadwalJamMulai;
  @JsonKey(name: 'jadwal_jam_selesai')
  final String? jadwalJamSelesai;
  @JsonKey(name: 'jam_masuk')
  final String? jamMasuk;
  @JsonKey(name: 'jam_keluar')
  final String? jamKeluar;
  final String status;
  @JsonKey(name: 'is_absen_bebas')
  final int isAbsenBebas;
  @JsonKey(name: 'istirahat_masuk')
  final String? istirahatMasuk;
  @JsonKey(name: 'istirahat_keluar')
  final String? istirahatKeluar;

  AttendanceDetail({
    required this.nama,
    required this.idPegawai,
    required this.foto,
    required this.jabatan,
    required this.namaSite,
    this.jadwalJamMulai,
    this.jadwalJamSelesai,
    this.jamMasuk,
    this.jamKeluar,
    required this.status,
    required this.isAbsenBebas,
    this.istirahatMasuk,
    this.istirahatKeluar,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailToJson(this);
}

@JsonSerializable()
class AttendanceDetailFilter {
  final List<Departemen> departemen;
  final List<String> jabatan;

  AttendanceDetailFilter({
    required this.departemen,
    required this.jabatan,
  });

  factory AttendanceDetailFilter.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFilterFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailFilterToJson(this);
}
