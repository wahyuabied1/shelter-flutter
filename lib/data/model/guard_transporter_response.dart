import 'package:json_annotation/json_annotation.dart';

part 'guard_transporter_response.g.dart';

@JsonSerializable()
class GuardTransporterResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardTransporter> data;
  final GuardTransporterFilter filter;

  GuardTransporterResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardTransporterResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterResponseToJson(this);
}

@JsonSerializable()
class GuardTransporter {
  final int id;
  final String tanggal;
  final GuardTransporterPetugas petugas;
  @JsonKey(name: 'jenis_kendaraan')
  final String? jenisKendaraan;
  @JsonKey(name: 'no_kendaraan')
  final String? noKendaraan;
  @JsonKey(name: 'perusahaan_angkutan')
  final String? perusahaanAngkutan;
  @JsonKey(name: 'nama_barang')
  final String? namaBarang;
  final String? sopir;
  final String? telpon;
  final String? masuk;
  final String? keluar;
  final String? keterangan;
  final String? ktp;
  @JsonKey(name: 'surat_jalan')
  final String? suratJalan;
  @JsonKey(name: 'no_surat')
  final String? noSurat;
  @JsonKey(name: 'no_container')
  final String? noContainer;

  GuardTransporter({
    required this.id,
    required this.tanggal,
    required this.petugas,
    this.jenisKendaraan,
    this.noKendaraan,
    this.perusahaanAngkutan,
    this.namaBarang,
    this.sopir,
    this.telpon,
    this.masuk,
    this.keluar,
    this.keterangan,
    this.ktp,
    this.suratJalan,
    this.noSurat,
    this.noContainer,
  });

  factory GuardTransporter.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterToJson(this);
}

@JsonSerializable()
class GuardTransporterPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardTransporterSite site;

  GuardTransporterPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardTransporterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterPetugasToJson(this);
}

@JsonSerializable()
class GuardTransporterSite {
  final int id;
  final String nama;

  GuardTransporterSite({
    required this.id,
    required this.nama,
  });

  factory GuardTransporterSite.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterSiteToJson(this);
}

@JsonSerializable()
class GuardTransporterFilter {
  @JsonKey(defaultValue: [])
  final List<GuardTransporterFilterPetugas> petugas;

  GuardTransporterFilter({
    required this.petugas,
  });

  factory GuardTransporterFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterFilterToJson(this);
}

@JsonSerializable()
class GuardTransporterFilterPetugas {
  final int id;
  final String nama;

  GuardTransporterFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardTransporterFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardTransporterFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTransporterFilterPetugasToJson(this);
}
