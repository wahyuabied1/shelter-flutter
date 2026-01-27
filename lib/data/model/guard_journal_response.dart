import 'package:json_annotation/json_annotation.dart';

part 'guard_journal_response.g.dart';

@JsonSerializable()
class GuardJournalResponse {
  final String status;
  @JsonKey(defaultValue: [])
  final List<GuardJournal> data;
  final GuardJournalFilter filter;

  GuardJournalResponse({
    required this.status,
    required this.data,
    required this.filter,
  });

  factory GuardJournalResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalResponseToJson(this);
}

@JsonSerializable()
class GuardJournal {
  final int id;
  final String tanggal;
  final GuardJournalPetugas petugas;
  final String shift;
  final String? mulai;
  final String? selesai;
  final String? laporan;
  @JsonKey(name: 'list_petugas')
  final String? listPetugas;

  GuardJournal({
    required this.id,
    required this.tanggal,
    required this.petugas,
    required this.shift,
    this.mulai,
    this.selesai,
    this.laporan,
    this.listPetugas,
  });

  factory GuardJournal.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalToJson(this);
}

@JsonSerializable()
class GuardJournalPetugas {
  final int id;
  final String nama;
  final String? photo;
  final GuardJournalSite site;

  GuardJournalPetugas({
    required this.id,
    required this.nama,
    this.photo,
    required this.site,
  });

  factory GuardJournalPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalPetugasToJson(this);
}

@JsonSerializable()
class GuardJournalSite {
  final int id;
  final String nama;

  GuardJournalSite({
    required this.id,
    required this.nama,
  });

  factory GuardJournalSite.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalSiteFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalSiteToJson(this);
}

@JsonSerializable()
class GuardJournalFilter {
  @JsonKey(defaultValue: [])
  final List<GuardJournalFilterPetugas> petugas;
  @JsonKey(defaultValue: [])
  final List<int> shift;

  GuardJournalFilter({
    required this.petugas,
    required this.shift,
  });

  factory GuardJournalFilter.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalFilterToJson(this);
}

@JsonSerializable()
class GuardJournalFilterPetugas {
  final int id;
  final String nama;

  GuardJournalFilterPetugas({
    required this.id,
    required this.nama,
  });

  factory GuardJournalFilterPetugas.fromJson(Map<String, dynamic> json) =>
      _$GuardJournalFilterPetugasFromJson(json);

  Map<String, dynamic> toJson() => _$GuardJournalFilterPetugasToJson(this);
}
