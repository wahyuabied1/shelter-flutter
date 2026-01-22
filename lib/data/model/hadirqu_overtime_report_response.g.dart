// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_overtime_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquOvertimeReportResponse _$HadirquOvertimeReportResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquOvertimeReportResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => OvertimeReport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: OvertimeFilter.fromJson(json['filter'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquOvertimeReportResponseToJson(
        HadirquOvertimeReportResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filter': instance.filter,
      'status': instance.status,
    };

OvertimeReport _$OvertimeReportFromJson(Map<String, dynamic> json) =>
    OvertimeReport(
      jumlahLembur: (json['jumlah_lembur'] as num).toInt(),
      durasi: json['durasi'] as String,
      pemohon: OvertimeUser.fromJson(json['pemohon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OvertimeReportToJson(OvertimeReport instance) =>
    <String, dynamic>{
      'jumlah_lembur': instance.jumlahLembur,
      'durasi': instance.durasi,
      'pemohon': instance.pemohon,
    };

OvertimeUser _$OvertimeUserFromJson(Map<String, dynamic> json) => OvertimeUser(
      nama: json['nama'] as String,
      departemen: json['departemen'] as String,
      idPegawai: json['id_pegawai'] as String,
      foto: json['foto'] as String,
    );

Map<String, dynamic> _$OvertimeUserToJson(OvertimeUser instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'departemen': instance.departemen,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
    };

OvertimeFilter _$OvertimeFilterFromJson(Map<String, dynamic> json) =>
    OvertimeFilter(
      departemen: (json['departemen'] as List<dynamic>?)
              ?.map(
                  (e) => OvertimeDepartemen.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: (json['status'] as List<dynamic>?)
              ?.map((e) => OvertimeStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OvertimeFilterToJson(OvertimeFilter instance) =>
    <String, dynamic>{
      'departemen': instance.departemen,
      'status': instance.status,
    };

OvertimeDepartemen _$OvertimeDepartemenFromJson(Map<String, dynamic> json) =>
    OvertimeDepartemen(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      totalPegawai: (json['total_pegawai'] as num).toInt(),
    );

Map<String, dynamic> _$OvertimeDepartemenToJson(OvertimeDepartemen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'total_pegawai': instance.totalPegawai,
    };

OvertimeStatus _$OvertimeStatusFromJson(Map<String, dynamic> json) =>
    OvertimeStatus(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$OvertimeStatusToJson(OvertimeStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
