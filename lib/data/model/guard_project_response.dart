import 'package:json_annotation/json_annotation.dart';

part 'guard_project_response.g.dart';

@JsonSerializable()
class GuardProjectResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardProject> data;
  final GuardProjectFilter filter;

  GuardProjectResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectResponseToJson(this);
}

@JsonSerializable()
class GuardProject {
  final int id;
  final String tanggal;
  final GuardProjectPetugas petugas;
  @JsonKey(name: 'area_pekerjaan')
  final String? areaPekerjaan;
  @JsonKey(name: 'nama_pekerjaan')
  final String? namaPekerjaan;
  @JsonKey(name: 'nama_perusahaan')
  final String? namaPerusahaan;
  @JsonKey(name: 'nama_pekerja')
  final String? namaPekerja;
  final String? masuk;
  final String? keluar;
  final String? keterangan;

  GuardProject({
    required this.id,
    required this.tanggal,
    required this.petugas,
    this.areaPekerjaan,
    this.namaPekerjaan,
    this.namaPerusahaan,
    this.namaPekerja,
    this.masuk,
    this.keluar,
    this.keterangan,
  });

  factory GuardProject.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectToJson(this);
}

@JsonSerializable()
class GuardProjectPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardProjectSite site;

  GuardProjectPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardProjectPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectPetugasToJson(this);
}

@JsonSerializable()
class GuardProjectSite {
  final int id;
  final String nama;

  GuardProjectSite({
    required this.id,
    required this.nama,
  });

  factory GuardProjectSite.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectSiteToJson(this);
}

@JsonSerializable()
class GuardProjectFilter {
  @JsonKey(defaultValue: [])
  final List<GuardProjectFilterPetugas> petugas;

  GuardProjectFilter({
    required this.petugas,
  });

  factory GuardProjectFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectFilterToJson(this);
}

@JsonSerializable()
class GuardProjectFilterPetugas {
  final int id;
  final String nama;

  GuardProjectFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardProjectFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardProjectFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardProjectFilterPetugasToJson(this);
}
