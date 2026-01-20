import 'package:json_annotation/json_annotation.dart';

import 'hadirqu_departement_filter_response.dart';

part 'hadirqu_presence_list_response.g.dart';

@JsonSerializable()
class HadirquPresenceListResponse {
  final List<PresenceData> data;
  final String status;
  final PresenceFilter filter;

  HadirquPresenceListResponse({
    required this.data,
    required this.status,
    required this.filter,
  });

  factory HadirquPresenceListResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquPresenceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquPresenceListResponseToJson(this);
}

@JsonSerializable()
class PresenceData {
  final Karyawan karyawan;
  final Map<String, int> presensi;
  @JsonKey(name: 'kode_presensi')
  final Map<String, int> kodePresensi;

  PresenceData({
    required this.karyawan,
    required this.presensi,
    required this.kodePresensi,
  });

  factory PresenceData.fromJson(Map<String, dynamic> json) =>
      _$PresenceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceDataToJson(this);
}

@JsonSerializable()
class Karyawan {
  final int id;
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final String idPegawai;
  final String jabatan;
  final String site;

  Karyawan({
    required this.id,
    required this.nama,
    required this.idPegawai,
    required this.jabatan,
    required this.site,
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) =>
      _$KaryawanFromJson(json);

  Map<String, dynamic> toJson() => _$KaryawanToJson(this);
}

@JsonSerializable()
class PresenceFilter {
  @JsonKey(name: 'status_absensi')
  final List<StatusAbsensi> statusAbsensi;
  final List<Departemen> departemen;
  final List<String> jabatan;

  PresenceFilter({
    required this.statusAbsensi,
    required this.departemen,
    required this.jabatan,
  });

  factory PresenceFilter.fromJson(Map<String, dynamic> json) =>
      _$PresenceFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceFilterToJson(this);
}

@JsonSerializable()
class StatusAbsensi {
  final int status;
  final String text;

  StatusAbsensi({
    required this.status,
    required this.text,
  });

  factory StatusAbsensi.fromJson(Map<String, dynamic> json) =>
      _$StatusAbsensiFromJson(json);

  Map<String, dynamic> toJson() => _$StatusAbsensiToJson(this);
}
