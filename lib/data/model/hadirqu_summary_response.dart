import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_summary_response.g.dart';

@JsonSerializable()
class HadirquSummaryResponse {
  @JsonKey(name: "total_karyawan")
  final int? totalKaryawan;
  @JsonKey(name: "kehadiran")
  final Kehadiran? kehadiran;
  @JsonKey(name: "lembur")
  final int? lembur;
  @JsonKey(name: "aktifitas")
  final int? aktifitas;

  HadirquSummaryResponse({
    this.totalKaryawan,
    this.kehadiran,
    this.lembur,
    this.aktifitas,
  });

  HadirquSummaryResponse copyWith({
    int? totalKaryawan,
    Kehadiran? kehadiran,
    int? lembur,
    int? aktifitas,
  }) =>
      HadirquSummaryResponse(
        totalKaryawan: totalKaryawan ?? this.totalKaryawan,
        kehadiran: kehadiran ?? this.kehadiran,
        lembur: lembur ?? this.lembur,
        aktifitas: aktifitas ?? this.aktifitas,
      );

  factory HadirquSummaryResponse.fromJson(Map<String, dynamic> json) => _$HadirquSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquSummaryResponseToJson(this);
}

@JsonSerializable()
class Kehadiran {
  @JsonKey(name: "hadir")
  final int? hadir;
  @JsonKey(name: "alpha")
  final int? alpha;
  @JsonKey(name: "cuti_izin")
  final int? cutiIzin;

  Kehadiran({
    this.hadir,
    this.alpha,
    this.cutiIzin,
  });

  Kehadiran copyWith({
    int? hadir,
    int? alpha,
    int? cutiIzin,
  }) =>
      Kehadiran(
        hadir: hadir ?? this.hadir,
        alpha: alpha ?? this.alpha,
        cutiIzin: cutiIzin ?? this.cutiIzin,
      );

  factory Kehadiran.fromJson(Map<String, dynamic> json) => _$KehadiranFromJson(json);

  Map<String, dynamic> toJson() => _$KehadiranToJson(this);
}

