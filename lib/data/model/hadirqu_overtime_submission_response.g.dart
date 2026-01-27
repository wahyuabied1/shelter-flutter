// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_overtime_submission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquOvertimeSubmissionResponse _$HadirquOvertimeSubmissionResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquOvertimeSubmissionResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => OvertimeSubmission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: OvertimeSubmissionFilter.fromJson(
          json['filter'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquOvertimeSubmissionResponseToJson(
        HadirquOvertimeSubmissionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filter': instance.filter,
      'status': instance.status,
    };

OvertimeSubmission _$OvertimeSubmissionFromJson(Map<String, dynamic> json) =>
    OvertimeSubmission(
      status: json['status'] as String,
      tanggal: json['tanggal'] as String,
      waktu: json['waktu'] as String,
      keterangan: json['keterangan'] as String,
      durasi: json['durasi'] as String,
      location:
          OvertimeLocation.fromJson(json['location'] as Map<String, dynamic>),
      berkas: (json['berkas'] as List<dynamic>)
          .map((e) => OvertimeBerkas.fromJson(e as Map<String, dynamic>))
          .toList(),
      pemohon: OvertimeSubmissionUser.fromJson(
          json['pemohon'] as Map<String, dynamic>),
      reviewer: json['reviewer'] == null
          ? null
          : OvertimeReviewer.fromJson(json['reviewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OvertimeSubmissionToJson(OvertimeSubmission instance) =>
    <String, dynamic>{
      'status': instance.status,
      'tanggal': instance.tanggal,
      'waktu': instance.waktu,
      'keterangan': instance.keterangan,
      'durasi': instance.durasi,
      'location': instance.location,
      'berkas': instance.berkas,
      'pemohon': instance.pemohon,
      'reviewer': instance.reviewer,
    };

OvertimeLocation _$OvertimeLocationFromJson(Map<String, dynamic> json) =>
    OvertimeLocation(
      mulai: LocationPoint.fromJson(json['mulai'] as Map<String, dynamic>),
      selesai: LocationPoint.fromJson(json['selesai'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OvertimeLocationToJson(OvertimeLocation instance) =>
    <String, dynamic>{
      'mulai': instance.mulai,
      'selesai': instance.selesai,
    };

LocationPoint _$LocationPointFromJson(Map<String, dynamic> json) =>
    LocationPoint(
      lat: json['lat'] as String,
      long: json['long'] as String,
    );

Map<String, dynamic> _$LocationPointToJson(LocationPoint instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };

OvertimeBerkas _$OvertimeBerkasFromJson(Map<String, dynamic> json) =>
    OvertimeBerkas(
      mulai: json['mulai'] as String?,
      selesai: json['selesai'] as String?,
    );

Map<String, dynamic> _$OvertimeBerkasToJson(OvertimeBerkas instance) =>
    <String, dynamic>{
      'mulai': instance.mulai,
      'selesai': instance.selesai,
    };

OvertimeSubmissionUser _$OvertimeSubmissionUserFromJson(
        Map<String, dynamic> json) =>
    OvertimeSubmissionUser(
      nama: json['nama'] as String,
      idPegawai: json['id_pegawai'] as String?,
      foto: json['foto'] as String?,
    );

Map<String, dynamic> _$OvertimeSubmissionUserToJson(
        OvertimeSubmissionUser instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
    };

OvertimeReviewer _$OvertimeReviewerFromJson(Map<String, dynamic> json) =>
    OvertimeReviewer(
      nama: json['nama'] as String,
      idPegawai: json['id_pegawai'] as String?,
      foto: json['foto'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OvertimeReviewerToJson(OvertimeReviewer instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
      'note': instance.note,
    };

OvertimeSubmissionFilter _$OvertimeSubmissionFilterFromJson(
        Map<String, dynamic> json) =>
    OvertimeSubmissionFilter(
      departemen: (json['departemen'] as List<dynamic>?)
              ?.map((e) => OvertimeSubmissionDepartemen.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      status: (json['status'] as List<dynamic>?)
              ?.map((e) =>
                  OvertimeSubmissionStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OvertimeSubmissionFilterToJson(
        OvertimeSubmissionFilter instance) =>
    <String, dynamic>{
      'departemen': instance.departemen,
      'status': instance.status,
    };

OvertimeSubmissionDepartemen _$OvertimeSubmissionDepartemenFromJson(
        Map<String, dynamic> json) =>
    OvertimeSubmissionDepartemen(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      totalPegawai: (json['total_pegawai'] as num).toInt(),
    );

Map<String, dynamic> _$OvertimeSubmissionDepartemenToJson(
        OvertimeSubmissionDepartemen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'total_pegawai': instance.totalPegawai,
    };

OvertimeSubmissionStatus _$OvertimeSubmissionStatusFromJson(
        Map<String, dynamic> json) =>
    OvertimeSubmissionStatus(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$OvertimeSubmissionStatusToJson(
        OvertimeSubmissionStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
