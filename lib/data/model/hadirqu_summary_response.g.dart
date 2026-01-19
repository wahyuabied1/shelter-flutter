// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquSummaryResponse _$HadirquSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquSummaryResponse(
      totalKaryawan: (json['total_karyawan'] as num?)?.toInt(),
      kehadiran: json['kehadiran'] == null
          ? null
          : Kehadiran.fromJson(json['kehadiran'] as Map<String, dynamic>),
      lembur: (json['lembur'] as num?)?.toInt(),
      aktifitas: (json['aktifitas'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HadirquSummaryResponseToJson(
        HadirquSummaryResponse instance) =>
    <String, dynamic>{
      'total_karyawan': instance.totalKaryawan,
      'kehadiran': instance.kehadiran,
      'lembur': instance.lembur,
      'aktifitas': instance.aktifitas,
    };

Kehadiran _$KehadiranFromJson(Map<String, dynamic> json) => Kehadiran(
      hadir: (json['hadir'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toInt(),
      cutiIzin: (json['cuti_izin'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KehadiranToJson(Kehadiran instance) => <String, dynamic>{
      'hadir': instance.hadir,
      'alpha': instance.alpha,
      'cuti_izin': instance.cutiIzin,
    };
