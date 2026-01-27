import 'package:json_annotation/json_annotation.dart';

part 'guard_phone_response.g.dart';

@JsonSerializable()
class GuardPhoneResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardPhone> data;
  final GuardPhoneFilter filter;

  GuardPhoneResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardPhoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhoneResponseToJson(this);
}

@JsonSerializable()
class GuardPhone {
  final int id;
  final String tanggal;
  final GuardPhonePetugas petugas;
  @JsonKey(name: 'nama_penelpon')
  final String? namaPenelpon;
  final String? tujuan;
  final String? keperluan;
  final String? mulai;
  final String? selesai;
  final String shift;

  GuardPhone({
    required this.id,
    required this.tanggal,
    required this.petugas,
    this.namaPenelpon,
    this.tujuan,
    this.keperluan,
    this.mulai,
    this.selesai,
    required this.shift,
  });

  factory GuardPhone.fromJson(Map<String, dynamic> json) =>
      _$GuardPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhoneToJson(this);
}

@JsonSerializable()
class GuardPhonePetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardPhoneSite site;

  GuardPhonePetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardPhonePetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardPhonePetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhonePetugasToJson(this);
}

@JsonSerializable()
class GuardPhoneSite {
  final int id;
  final String nama;

  GuardPhoneSite({
    required this.id,
    required this.nama,
  });

  factory GuardPhoneSite.fromJson(Map<String, dynamic> json) =>
      _$GuardPhoneSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhoneSiteToJson(this);
}

@JsonSerializable()
class GuardPhoneFilter {
  @JsonKey(defaultValue: [])
  final List<int> shift;
  @JsonKey(defaultValue: [])
  final List<GuardPhoneFilterPetugas> petugas;

  GuardPhoneFilter({
    required this.shift,
    required this.petugas,
  });

  factory GuardPhoneFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardPhoneFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhoneFilterToJson(this);
}

@JsonSerializable()
class GuardPhoneFilterPetugas {
  final int id;
  final String nama;

  GuardPhoneFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardPhoneFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardPhoneFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardPhoneFilterPetugasToJson(this);
}
