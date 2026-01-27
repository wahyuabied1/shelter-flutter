// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardSummaryResponse _$GuardSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GuardSummaryResponse(
      status: json['status'] as String,
      data: GuardSummaryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardSummaryResponseToJson(
        GuardSummaryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GuardSummaryData _$GuardSummaryDataFromJson(Map<String, dynamic> json) =>
    GuardSummaryData(
      petugas: (json['petugas'] as num).toInt(),
      absensi: (json['absensi'] as num).toInt(),
      checklist: (json['checklist'] as num).toInt(),
      berita: (json['berita'] as num).toInt(),
      tanggalMulai: json['tanggal_mulai'] as String,
      tanggalSelesai: json['tanggal_selesai'] as String,
    );

Map<String, dynamic> _$GuardSummaryDataToJson(GuardSummaryData instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
      'absensi': instance.absensi,
      'checklist': instance.checklist,
      'berita': instance.berita,
      'tanggal_mulai': instance.tanggalMulai,
      'tanggal_selesai': instance.tanggalSelesai,
    };
