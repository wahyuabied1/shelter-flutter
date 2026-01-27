import 'package:json_annotation/json_annotation.dart';

part 'guard_news_response.g.dart';

@JsonSerializable()
class GuardNewsResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardNews> data;
  final GuardNewsFilter filter;

  GuardNewsResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardNewsResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsResponseToJson(this);
}

@JsonSerializable()
class GuardNews {
  final int id;
  final String tanggal;
  final GuardNewsPetugas petugas;
  final String shift;
  @JsonKey(name: 'nama_pelapor')
  final String? namaPelapor;
  final String? temuan;
  final String? tindakan;
  final String? diketahui;

  GuardNews({
    required this.id,
    required this.tanggal,
    required this.petugas,
    required this.shift,
    this.namaPelapor,
    this.temuan,
    this.tindakan,
    this.diketahui,
  });

  factory GuardNews.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsToJson(this);
}

@JsonSerializable()
class GuardNewsPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardNewsSite site;

  GuardNewsPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardNewsPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsPetugasToJson(this);
}

@JsonSerializable()
class GuardNewsSite {
  final int id;
  final String nama;

  GuardNewsSite({
    required this.id,
    required this.nama,
  });

  factory GuardNewsSite.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsSiteToJson(this);
}

@JsonSerializable()
class GuardNewsFilter {
  @JsonKey(defaultValue: [])
  final List<GuardNewsFilterPetugas> petugas;
  @JsonKey(defaultValue: [])
  final List<int> shift;

  GuardNewsFilter({
    required this.petugas,
    required this.shift,
  });

  factory GuardNewsFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsFilterToJson(this);
}

@JsonSerializable()
class GuardNewsFilterPetugas {
  final int id;
  final String nama;

  GuardNewsFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardNewsFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardNewsFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardNewsFilterPetugasToJson(this);
}
