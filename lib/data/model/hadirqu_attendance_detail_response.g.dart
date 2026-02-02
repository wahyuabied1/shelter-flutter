// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_attendance_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquAttendanceDetailResponse _$HadirquAttendanceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquAttendanceDetailResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AttendanceDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: json['filter'] == null
          ? null
          : AttendanceDetailFilter.fromJson(
              json['filter'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquAttendanceDetailResponseToJson(
        HadirquAttendanceDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filter': instance.filter,
      'status': instance.status,
    };

AttendanceDetail _$AttendanceDetailFromJson(Map<String, dynamic> json) =>
    AttendanceDetail(
      nama: json['nama'] as String,
      idPegawai: json['id_pegawai'] as String,
      foto: json['foto'] as String,
      jabatan: json['jabatan'] as String,
      namaSite: json['nama_site'] as String,
      jadwalJamMulai: json['jadwal_jam_mulai'] as String?,
      jadwalJamSelesai: json['jadwal_jam_selesai'] as String?,
      jamMasuk: json['jam_masuk'] as String?,
      jamKeluar: json['jam_keluar'] as String?,
      status: json['status'] as String,
      isAbsenBebas: (json['is_absen_bebas'] as num).toInt(),
      istirahatMasuk: json['istirahat_masuk'] as String?,
      istirahatKeluar: json['istirahat_keluar'] as String?,
    );

Map<String, dynamic> _$AttendanceDetailToJson(AttendanceDetail instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
      'jabatan': instance.jabatan,
      'nama_site': instance.namaSite,
      'jadwal_jam_mulai': instance.jadwalJamMulai,
      'jadwal_jam_selesai': instance.jadwalJamSelesai,
      'jam_masuk': instance.jamMasuk,
      'jam_keluar': instance.jamKeluar,
      'status': instance.status,
      'is_absen_bebas': instance.isAbsenBebas,
      'istirahat_masuk': instance.istirahatMasuk,
      'istirahat_keluar': instance.istirahatKeluar,
    };

AttendanceDetailFilter _$AttendanceDetailFilterFromJson(
        Map<String, dynamic> json) =>
    AttendanceDetailFilter(
      departemen: (json['departemen'] as List<dynamic>?)
              ?.map((e) => Departemen.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      jabatan: (json['jabatan'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      statusAbsensi: (json['status_absensi'] as List<dynamic>?)
              ?.map((e) => StatusAbsensi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AttendanceDetailFilterToJson(
        AttendanceDetailFilter instance) =>
    <String, dynamic>{
      'departemen': instance.departemen,
      'jabatan': instance.jabatan,
      'status_absensi': instance.statusAbsensi,
    };

StatusAbsensi _$StatusAbsensiFromJson(Map<String, dynamic> json) =>
    StatusAbsensi(
      status: (json['status'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$StatusAbsensiToJson(StatusAbsensi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'text': instance.text,
    };
