// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquReportResponse _$HadirquReportResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquReportResponse(
      data: json['data'] == null
          ? null
          : HadirquReportData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String?,
      filter: json['filter'] == null
          ? null
          : HadirquFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HadirquReportResponseToJson(
        HadirquReportResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'filter': instance.filter,
    };

HadirquReportData _$HadirquReportDataFromJson(Map<String, dynamic> json) =>
    HadirquReportData(
      jumlahKaryawan: (json['jumlah_karyawan'] as num?)?.toInt(),
      kehadiran: (json['kehadiran'] as num?)?.toInt(),
      terlambat: (json['terlambat'] as num?)?.toInt(),
      diluarLokasi: (json['diluar_lokasi'] as num?)?.toInt(),
      pulangCepat: (json['pulang_cepat'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toInt(),
      izin: (json['izin'] as num?)?.toInt(),
      sakit: (json['sakit'] as num?)?.toInt(),
      cuti: (json['cuti'] as num?)?.toInt(),
      clockinPertama: json['clockin_pertama'] as String?,
      clockoutTerakhir: json['clockout_terakhir'] as String?,
      clockinAvg: json['clockin_avg'] as String?,
      clockoutAvg: json['clockout_avg'] as String?,
      durasiAvg: json['durasi_avg'] as String?,
      durasiIstirahatAvg: json['durasi_istirahat_avg'] as String?,
      ketidakhadiran: (json['ketidakhadiran'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HadirquReportDataToJson(HadirquReportData instance) =>
    <String, dynamic>{
      'jumlah_karyawan': instance.jumlahKaryawan,
      'kehadiran': instance.kehadiran,
      'terlambat': instance.terlambat,
      'diluar_lokasi': instance.diluarLokasi,
      'pulang_cepat': instance.pulangCepat,
      'alpha': instance.alpha,
      'izin': instance.izin,
      'sakit': instance.sakit,
      'cuti': instance.cuti,
      'clockin_pertama': instance.clockinPertama,
      'clockout_terakhir': instance.clockoutTerakhir,
      'clockin_avg': instance.clockinAvg,
      'clockout_avg': instance.clockoutAvg,
      'durasi_avg': instance.durasiAvg,
      'durasi_istirahat_avg': instance.durasiIstirahatAvg,
      'ketidakhadiran': instance.ketidakhadiran,
    };

HadirquFilter _$HadirquFilterFromJson(Map<String, dynamic> json) =>
    HadirquFilter(
      departemen: (json['departemen'] as List<dynamic>?)
          ?.map((e) => Departemen.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HadirquFilterToJson(HadirquFilter instance) =>
    <String, dynamic>{
      'departemen': instance.departemen,
    };
