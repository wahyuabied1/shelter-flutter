import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_report_response.g.dart';

// Main wrapper response - mirip HadirquSummaryResponse
@JsonSerializable()
class HadirquReportResponse {
  @JsonKey(name: 'data')
  final HadirquReportData? data;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'filter')
  final HadirquFilter? filter;

  HadirquReportResponse({
    this.data,
    this.status,
    this.filter,
  });

  HadirquReportResponse copyWith({
    HadirquReportData? data,
    String? status,
    HadirquFilter? filter,
  }) =>
      HadirquReportResponse(
        data: data ?? this.data,
        status: status ?? this.status,
        filter: filter ?? this.filter,
      );

  factory HadirquReportResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquReportResponseToJson(this);
}

// Data object - mirip Kehadiran di HadirquSummaryResponse
@JsonSerializable()
class HadirquReportData {
  @JsonKey(name: 'jumlah_karyawan')
  final int? jumlahKaryawan;

  @JsonKey(name: 'kehadiran')
  final int? kehadiran;

  @JsonKey(name: 'terlambat')
  final int? terlambat;

  @JsonKey(name: 'diluar_lokasi')
  final int? diluarLokasi;

  @JsonKey(name: 'pulang_cepat')
  final int? pulangCepat;

  @JsonKey(name: 'alpha')
  final int? alpha;

  @JsonKey(name: 'izin')
  final int? izin;

  @JsonKey(name: 'sakit')
  final int? sakit;

  @JsonKey(name: 'cuti')
  final int? cuti;

  @JsonKey(name: 'clockin_pertama')
  final String? clockinPertama;

  @JsonKey(name: 'clockout_terakhir')
  final String? clockoutTerakhir;

  @JsonKey(name: 'clockin_avg')
  final String? clockinAvg;

  @JsonKey(name: 'clockout_avg')
  final String? clockoutAvg;

  @JsonKey(name: 'durasi_avg')
  final String? durasiAvg;

  @JsonKey(name: 'durasi_istirahat_avg')
  final String? durasiIstirahatAvg;

  @JsonKey(name: 'ketidakhadiran')
  final int? ketidakhadiran;

  HadirquReportData({
    this.jumlahKaryawan,
    this.kehadiran,
    this.terlambat,
    this.diluarLokasi,
    this.pulangCepat,
    this.alpha,
    this.izin,
    this.sakit,
    this.cuti,
    this.clockinPertama,
    this.clockoutTerakhir,
    this.clockinAvg,
    this.clockoutAvg,
    this.durasiAvg,
    this.durasiIstirahatAvg,
    this.ketidakhadiran,
  });

  HadirquReportData copyWith({
    int? jumlahKaryawan,
    int? kehadiran,
    int? terlambat,
    int? diluarLokasi,
    int? pulangCepat,
    int? alpha,
    int? izin,
    int? sakit,
    int? cuti,
    String? clockinPertama,
    String? clockoutTerakhir,
    String? clockinAvg,
    String? clockoutAvg,
    String? durasiAvg,
    String? durasiIstirahatAvg,
    int? ketidakhadiran,
  }) =>
      HadirquReportData(
        jumlahKaryawan: jumlahKaryawan ?? this.jumlahKaryawan,
        kehadiran: kehadiran ?? this.kehadiran,
        terlambat: terlambat ?? this.terlambat,
        diluarLokasi: diluarLokasi ?? this.diluarLokasi,
        pulangCepat: pulangCepat ?? this.pulangCepat,
        alpha: alpha ?? this.alpha,
        izin: izin ?? this.izin,
        sakit: sakit ?? this.sakit,
        cuti: cuti ?? this.cuti,
        clockinPertama: clockinPertama ?? this.clockinPertama,
        clockoutTerakhir: clockoutTerakhir ?? this.clockoutTerakhir,
        clockinAvg: clockinAvg ?? this.clockinAvg,
        clockoutAvg: clockoutAvg ?? this.clockoutAvg,
        durasiAvg: durasiAvg ?? this.durasiAvg,
        durasiIstirahatAvg: durasiIstirahatAvg ?? this.durasiIstirahatAvg,
        ketidakhadiran: ketidakhadiran ?? this.ketidakhadiran,
      );

  factory HadirquReportData.fromJson(Map<String, dynamic> json) =>
      _$HadirquReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquReportDataToJson(this);
}

@JsonSerializable()
class HadirquFilter {
  @JsonKey(name: 'departemen')
  final List<Departemen>? departemen;

  HadirquFilter({
    this.departemen,
  });

  HadirquFilter copyWith({
    List<Departemen>? departemen,
  }) =>
      HadirquFilter(
        departemen: departemen ?? this.departemen,
      );

  factory HadirquFilter.fromJson(Map<String, dynamic> json) =>
      _$HadirquFilterFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquFilterToJson(this);
}

@JsonSerializable()
class Departemen {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'nama')
  final String? nama;

  @JsonKey(name: 'total_pegawai')
  final int? totalPegawai;

  Departemen({
    this.id,
    this.nama,
    this.totalPegawai,
  });

  Departemen copyWith({
    int? id,
    String? nama,
    int? totalPegawai,
  }) =>
      Departemen(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        totalPegawai: totalPegawai ?? this.totalPegawai,
      );

  factory Departemen.fromJson(Map<String, dynamic> json) =>
      _$DepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$DepartemenToJson(this);
}