import 'package:json_annotation/json_annotation.dart';

part 'guard_guest_response.g.dart';

@JsonSerializable()
class GuardGuestResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardGuest> data;
  final GuardGuestFilter filter;

  GuardGuestResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardGuestResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestResponseToJson(this);
}

@JsonSerializable()
class GuardGuest {
  final int id;
  final String tanggal;
  final GuardGuestPetugas petugas;
  @JsonKey(name: 'nama_tamu')
  final String? namaTamu;
  @JsonKey(name: 'nama_perusahaan')
  final String? namaPerusahaan;
  final String? tujuan;
  final String? keperluan;
  final String shift;
  final String? masuk;
  final String? keluar;
  final String? departemen;
  final String? keterangan;
  @JsonKey(defaultValue: [])
  final List<String> photo;

  GuardGuest({
    required this.id,
    required this.tanggal,
    required this.petugas,
    this.namaTamu,
    this.namaPerusahaan,
    this.tujuan,
    this.keperluan,
    required this.shift,
    this.masuk,
    this.keluar,
    this.departemen,
    this.keterangan,
    required this.photo,
  });

  factory GuardGuest.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestToJson(this);
}

@JsonSerializable()
class GuardGuestPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardGuestSite site;

  GuardGuestPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardGuestPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestPetugasToJson(this);
}

@JsonSerializable()
class GuardGuestSite {
  final int id;
  final String nama;

  GuardGuestSite({
    required this.id,
    required this.nama,
  });

  factory GuardGuestSite.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestSiteToJson(this);
}

@JsonSerializable()
class GuardGuestFilter {
  @JsonKey(defaultValue: [])
  final List<int> shift;
  @JsonKey(defaultValue: [])
  final List<GuardGuestFilterPetugas> petugas;

  GuardGuestFilter({
    required this.shift,
    required this.petugas,
  });

  factory GuardGuestFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestFilterToJson(this);
}

@JsonSerializable()
class GuardGuestFilterPetugas {
  final int id;
  final String nama;

  GuardGuestFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardGuestFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardGuestFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardGuestFilterPetugasToJson(this);
}
