// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_presence_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquPresenceListResponse _$HadirquPresenceListResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquPresenceListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PresenceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      filter: PresenceFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HadirquPresenceListResponseToJson(
        HadirquPresenceListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'filter': instance.filter,
    };

PresenceData _$PresenceDataFromJson(Map<String, dynamic> json) => PresenceData(
      karyawan: Karyawan.fromJson(json['karyawan'] as Map<String, dynamic>),
      presensi: Map<String, int>.from(json['presensi'] as Map),
      kodePresensi: Map<String, int>.from(json['kode_presensi'] as Map),
    );

Map<String, dynamic> _$PresenceDataToJson(PresenceData instance) =>
    <String, dynamic>{
      'karyawan': instance.karyawan,
      'presensi': instance.presensi,
      'kode_presensi': instance.kodePresensi,
    };

Karyawan _$KaryawanFromJson(Map<String, dynamic> json) => Karyawan(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      idPegawai: json['id_pegawai'] as String,
      jabatan: json['jabatan'] as String,
      site: json['site'] as String,
    );

Map<String, dynamic> _$KaryawanToJson(Karyawan instance) => <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'jabatan': instance.jabatan,
      'site': instance.site,
    };

PresenceFilter _$PresenceFilterFromJson(Map<String, dynamic> json) =>
    PresenceFilter(
      statusAbsensi: (json['status_absensi'] as List<dynamic>)
          .map((e) => StatusAbsensi.fromJson(e as Map<String, dynamic>))
          .toList(),
      departemen: (json['departemen'] as List<dynamic>)
          .map((e) => Departemen.fromJson(e as Map<String, dynamic>))
          .toList(),
      jabatan:
          (json['jabatan'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PresenceFilterToJson(PresenceFilter instance) =>
    <String, dynamic>{
      'status_absensi': instance.statusAbsensi,
      'departemen': instance.departemen,
      'jabatan': instance.jabatan,
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
