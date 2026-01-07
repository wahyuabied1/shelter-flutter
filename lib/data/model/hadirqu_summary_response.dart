import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_summary_response.g.dart';

@JsonSerializable()
class HadirquSummaryResponse {
  @JsonKey(name: "total_karyawan")
  final int? totalKaryawan;
  @JsonKey(name: "total_hadir")
  final int? totalHadir;
  @JsonKey(name: "total_alpha")
  final int? totalAlpha;
  @JsonKey(name: "total_cuti_izin")
  final int? totalCutiIzin;

  HadirquSummaryResponse({
    this.totalKaryawan,
    this.totalHadir,
    this.totalAlpha,
    this.totalCutiIzin,
  });

  HadirquSummaryResponse copyWith({
    int? totalKaryawan,
    int? totalHadir,
    int? totalAlpha,
    int? totalCutiIzin,
  }) =>
      HadirquSummaryResponse(
        totalKaryawan: totalKaryawan ?? this.totalKaryawan,
        totalHadir: totalHadir ?? this.totalHadir,
        totalAlpha: totalAlpha ?? this.totalAlpha,
        totalCutiIzin: totalCutiIzin ?? this.totalCutiIzin,
      );

  factory HadirquSummaryResponse.fromJson(Map<String, dynamic> json) => _$HadirquSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquSummaryResponseToJson(this);
}
