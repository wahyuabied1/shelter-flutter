import 'package:json_annotation/json_annotation.dart';

part 'guard_operasional_response.g.dart';

@JsonSerializable()
class GuardOperasionalResponse {
  final String status;
  final List<GuardOperasional> data;
  final GuardOperasionalFilter? filter;

  GuardOperasionalResponse({
    required this.status,
    required this.data,
    this.filter,
  });

  factory GuardOperasionalResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalResponseToJson(this);
}

@JsonSerializable()
class GuardOperasional {
  final int id;
  final String tanggal;
  final GuardOperasionalSopir sopir;
  final GuardOperasionalPetugas petugas;
  final GuardOperasionalKendaraan kendaraan;
  @JsonKey(name: 'km_masuk')
  final int? kmMasuk;
  @JsonKey(name: 'km_keluar')
  final int? kmKeluar;
  @JsonKey(name: 'jam_masuk')
  final String? jamMasuk; // Ubah ke nullable
  @JsonKey(name: 'jam_keluar')
  final String? jamKeluar; // Ubah ke nullable
  final String? keterangan; // Ubah ke nullable
  final String? tujuan; // Ubah ke nullable

  GuardOperasional({
    required this.id,
    required this.tanggal,
    required this.sopir,
    required this.petugas,
    required this.kendaraan,
    this.kmMasuk,
    this.kmKeluar,
    this.jamMasuk,
    this.jamKeluar,
    this.keterangan,
    this.tujuan,
  });

  factory GuardOperasional.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalToJson(this);
}

@JsonSerializable()
class GuardOperasionalSopir {
  final int id;
  final String nama;
  @JsonKey(name: 'no_telp')
  final String? noTelp; // Ubah ke nullable

  GuardOperasionalSopir({
    required this.id,
    required this.nama,
    this.noTelp,
  });

  factory GuardOperasionalSopir.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalSopirFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalSopirToJson(this);
}

@JsonSerializable()
class GuardOperasionalPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardOperasionalPetugasSite site;

  GuardOperasionalPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardOperasionalPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalPetugasToJson(this);
}

@JsonSerializable()
class GuardOperasionalPetugasSite {
  final int id;
  final String nama;

  GuardOperasionalPetugasSite({
    required this.id,
    required this.nama,
  });

  factory GuardOperasionalPetugasSite.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalPetugasSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalPetugasSiteToJson(this);
}

@JsonSerializable()
class GuardOperasionalKendaraan {
  final int id;
  @JsonKey(name: 'no_plat')
  final String noPlat;

  GuardOperasionalKendaraan({
    required this.id,
    required this.noPlat,
  });

  factory GuardOperasionalKendaraan.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalKendaraanFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalKendaraanToJson(this);
}

@JsonSerializable()
class GuardOperasionalFilter {
  final List<GuardOperasionalFilterKendaraan> kendaraan;
  final List<GuardOperasionalFilterPetugas> petugas;

  GuardOperasionalFilter({
    required this.kendaraan,
    required this.petugas,
  });

  factory GuardOperasionalFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalFilterToJson(this);
}

@JsonSerializable()
class GuardOperasionalFilterKendaraan {
  final int id;
  @JsonKey(name: 'no_plat')
  final String noPlat;

  GuardOperasionalFilterKendaraan({
    required this.id,
    required this.noPlat,
  });

  factory GuardOperasionalFilterKendaraan.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalFilterKendaraanFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GuardOperasionalFilterKendaraanToJson(this);
}

@JsonSerializable()
class GuardOperasionalFilterPetugas {
  final int id;
  final String nama;

  GuardOperasionalFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardOperasionalFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardOperasionalFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardOperasionalFilterPetugasToJson(this);
}
