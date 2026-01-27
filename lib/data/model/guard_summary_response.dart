import 'package:json_annotation/json_annotation.dart';

part 'guard_summary_response.g.dart';

@JsonSerializable()
class GuardSummaryResponse {
  final String status;
  final GuardSummaryData data;

  GuardSummaryResponse({
    required this.status,
    required this.data,
  });

  factory GuardSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GuardSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardSummaryResponseToJson(this);
}

@JsonSerializable()
class GuardSummaryData {
  final int petugas;
  final int absensi;
  final int checklist;
  final int berita;
  @JsonKey(name: 'tanggal_mulai')
  final String tanggalMulai;
  @JsonKey(name: 'tanggal_selesai')
  final String tanggalSelesai;

  GuardSummaryData({
    required this.petugas,
    required this.absensi,
    required this.checklist,
    required this.berita,
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  factory GuardSummaryData.fromJson(Map<String, dynamic> json) =>
      _$GuardSummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$GuardSummaryDataToJson(this);
}
