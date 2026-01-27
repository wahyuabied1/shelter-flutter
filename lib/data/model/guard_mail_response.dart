import 'package:json_annotation/json_annotation.dart';

part 'guard_mail_response.g.dart';

@JsonSerializable()
class GuardMailResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardMail> data;
  final GuardMailFilter filter;

  GuardMailResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardMailResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardMailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailResponseToJson(this);
}

@JsonSerializable()
class GuardMail {
  final int id;
  final String tanggal;
  final GuardMailPetugas petugas;
  final String shift;
  @JsonKey(name: 'nama_pengirim')
  final String? namaPengirim;
  @JsonKey(name: 'alamat_pengirim')
  final String? alamatPengirim;
  @JsonKey(name: 'nama_penerima')
  final String? namaPenerima;
  @JsonKey(name: 'jenis_surat')
  final String? jenisSurat;
  final String? kurir;
  @JsonKey(name: 'no_resi')
  final String? noResi;
  final int? jumlah;
  final String? keterangan;

  GuardMail({
    required this.id,
    required this.tanggal,
    required this.petugas,
    required this.shift,
    this.namaPengirim,
    this.alamatPengirim,
    this.namaPenerima,
    this.jenisSurat,
    this.kurir,
    this.noResi,
    this.jumlah,
    this.keterangan,
  });

  factory GuardMail.fromJson(Map<String, dynamic> json) =>
      _$GuardMailFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailToJson(this);
}

@JsonSerializable()
class GuardMailPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardMailSite site;

  GuardMailPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardMailPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardMailPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailPetugasToJson(this);
}

@JsonSerializable()
class GuardMailSite {
  final int id;
  final String nama;

  GuardMailSite({
    required this.id,
    required this.nama,
  });

  factory GuardMailSite.fromJson(Map<String, dynamic> json) =>
      _$GuardMailSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailSiteToJson(this);
}

@JsonSerializable()
class GuardMailFilter {
  @JsonKey(defaultValue: [])
  final List<GuardMailFilterPetugas> petugas;
  @JsonKey(defaultValue: [])
  final List<int> shift;

  GuardMailFilter({
    required this.petugas,
    required this.shift,
  });

  factory GuardMailFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardMailFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailFilterToJson(this);
}

@JsonSerializable()
class GuardMailFilterPetugas {
  final int id;
  final String nama;

  GuardMailFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardMailFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardMailFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardMailFilterPetugasToJson(this);
}
