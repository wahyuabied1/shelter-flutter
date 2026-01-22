// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_leave_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquLeaveReportResponse _$HadirquLeaveReportResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquLeaveReportResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => LeaveReport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: LeaveFilter.fromJson(json['filter'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquLeaveReportResponseToJson(
        HadirquLeaveReportResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filter': instance.filter,
      'status': instance.status,
    };

LeaveReport _$LeaveReportFromJson(Map<String, dynamic> json) => LeaveReport(
      status: json['status'] as String,
      waktu: json['waktu'] as String,
      durasi: (json['durasi'] as num).toInt(),
      keterangan: json['keterangan'] as String,
      file: LeaveFile.fromJson(json['file'] as Map<String, dynamic>),
      pemohon: LeaveUser.fromJson(json['pemohon'] as Map<String, dynamic>),
      reviewer: json['reviewer'] == null
          ? null
          : LeaveUser.fromJson(json['reviewer'] as Map<String, dynamic>),
      review: json['review'] as String?,
      potongJatah: json['potong_jatah'] as bool,
      site: LeaveSite.fromJson(json['site'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      jenisCuti: JenisCuti.fromJson(json['jenis_cuti'] as Map<String, dynamic>),
      potongJatahCuti: json['potong_jatah_cuti'] as bool,
    );

Map<String, dynamic> _$LeaveReportToJson(LeaveReport instance) =>
    <String, dynamic>{
      'status': instance.status,
      'waktu': instance.waktu,
      'durasi': instance.durasi,
      'keterangan': instance.keterangan,
      'file': instance.file,
      'pemohon': instance.pemohon,
      'reviewer': instance.reviewer,
      'review': instance.review,
      'potong_jatah': instance.potongJatah,
      'site': instance.site,
      'created_at': instance.createdAt,
      'jenis_cuti': instance.jenisCuti,
      'potong_jatah_cuti': instance.potongJatahCuti,
    };

LeaveFile _$LeaveFileFromJson(Map<String, dynamic> json) => LeaveFile(
      path: json['path'] as String,
      ext: json['ext'] as String?,
    );

Map<String, dynamic> _$LeaveFileToJson(LeaveFile instance) => <String, dynamic>{
      'path': instance.path,
      'ext': instance.ext,
    };

LeaveUser _$LeaveUserFromJson(Map<String, dynamic> json) => LeaveUser(
      nama: json['nama'] as String,
      idPegawai: json['id_pegawai'] as String?,
      foto: json['foto'] as String,
    );

Map<String, dynamic> _$LeaveUserToJson(LeaveUser instance) => <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
    };

LeaveSite _$LeaveSiteFromJson(Map<String, dynamic> json) => LeaveSite(
      idSite: (json['id_site'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$LeaveSiteToJson(LeaveSite instance) => <String, dynamic>{
      'id_site': instance.idSite,
      'nama': instance.nama,
    };

JenisCuti _$JenisCutiFromJson(Map<String, dynamic> json) => JenisCuti(
      id: json['id'] as String,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$JenisCutiToJson(JenisCuti instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
    };

LeaveFilter _$LeaveFilterFromJson(Map<String, dynamic> json) => LeaveFilter(
      status: (json['status'] as List<dynamic>?)
              ?.map((e) => LeaveStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      departemen: (json['departemen'] as List<dynamic>?)
              ?.map((e) => LeaveDepartemen.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LeaveFilterToJson(LeaveFilter instance) =>
    <String, dynamic>{
      'status': instance.status,
      'departemen': instance.departemen,
    };

LeaveStatus _$LeaveStatusFromJson(Map<String, dynamic> json) => LeaveStatus(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$LeaveStatusToJson(LeaveStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

LeaveDepartemen _$LeaveDepartemenFromJson(Map<String, dynamic> json) =>
    LeaveDepartemen(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      totalPegawai: (json['total_pegawai'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveDepartemenToJson(LeaveDepartemen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'total_pegawai': instance.totalPegawai,
    };
