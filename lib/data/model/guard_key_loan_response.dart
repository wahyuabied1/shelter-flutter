import 'package:json_annotation/json_annotation.dart';

part 'guard_key_loan_response.g.dart';

@JsonSerializable()
class GuardKeyLoanResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardKeyLoan> data;
  final GuardKeyLoanFilter filter;

  GuardKeyLoanResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardKeyLoanResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanResponseToJson(this);
}

@JsonSerializable()
class GuardKeyLoan {
  final int id;
  final GuardKeyLoanPetugas petugas;
  final String shift;
  final GuardKeyLoanRuang ruang;
  final String tanggal;
  @JsonKey(name: 'jam_ambil')
  final String? jamAmbil;
  @JsonKey(name: 'jam_kembali')
  final String? jamKembali;
  final String? peminjam;
  final String? pengembali;

  GuardKeyLoan({
    required this.id,
    required this.petugas,
    required this.shift,
    required this.ruang,
    required this.tanggal,
    this.jamAmbil,
    this.jamKembali,
    this.peminjam,
    this.pengembali,
  });

  factory GuardKeyLoan.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanToJson(this);
}

@JsonSerializable()
class GuardKeyLoanPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardKeyLoanSite site;

  GuardKeyLoanPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardKeyLoanPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanPetugasToJson(this);
}

@JsonSerializable()
class GuardKeyLoanSite {
  final int id;
  final String nama;

  GuardKeyLoanSite({
    required this.id,
    required this.nama,
  });

  factory GuardKeyLoanSite.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanSiteToJson(this);
}

@JsonSerializable()
class GuardKeyLoanRuang {
  final int id;
  final String nama;

  GuardKeyLoanRuang({
    required this.id,
    required this.nama,
  });

  factory GuardKeyLoanRuang.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanRuangFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanRuangToJson(this);
}

@JsonSerializable()
class GuardKeyLoanFilter {
  @JsonKey(defaultValue: [])
  final List<int> shift;
  @JsonKey(defaultValue: [])
  final List<GuardKeyLoanFilterRuangan> ruangan;
  @JsonKey(defaultValue: [])
  final List<GuardKeyLoanFilterPetugas> petugas;

  GuardKeyLoanFilter({
    required this.shift,
    required this.ruangan,
    required this.petugas,
  });

  factory GuardKeyLoanFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanFilterToJson(this);
}

@JsonSerializable()
class GuardKeyLoanFilterRuangan {
  final int id;
  final String nama;

  GuardKeyLoanFilterRuangan({
    required this.id,
    required this.nama,
  });

  factory GuardKeyLoanFilterRuangan.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanFilterRuanganFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanFilterRuanganToJson(this);
}

@JsonSerializable()
class GuardKeyLoanFilterPetugas {
  final int id;
  final String nama;

  GuardKeyLoanFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardKeyLoanFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardKeyLoanFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardKeyLoanFilterPetugasToJson(this);
}
