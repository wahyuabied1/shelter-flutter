// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardProjectResponse _$GuardProjectResponseFromJson(
        Map<String, dynamic> json) =>
    GuardProjectResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardProject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter:
          GuardProjectFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardProjectResponseToJson(
        GuardProjectResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardProject _$GuardProjectFromJson(Map<String, dynamic> json) => GuardProject(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardProjectPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      areaPekerjaan: json['area_pekerjaan'] as String?,
      namaPekerjaan: json['nama_pekerjaan'] as String?,
      namaPerusahaan: json['nama_perusahaan'] as String?,
      namaPekerja: json['nama_pekerja'] as String?,
      masuk: json['masuk'] as String?,
      keluar: json['keluar'] as String?,
      keterangan: json['keterangan'] as String?,
    );

Map<String, dynamic> _$GuardProjectToJson(GuardProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'area_pekerjaan': instance.areaPekerjaan,
      'nama_pekerjaan': instance.namaPekerjaan,
      'nama_perusahaan': instance.namaPerusahaan,
      'nama_pekerja': instance.namaPekerja,
      'masuk': instance.masuk,
      'keluar': instance.keluar,
      'keterangan': instance.keterangan,
    };

GuardProjectPetugas _$GuardProjectPetugasFromJson(Map<String, dynamic> json) =>
    GuardProjectPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardProjectSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardProjectPetugasToJson(
        GuardProjectPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardProjectSite _$GuardProjectSiteFromJson(Map<String, dynamic> json) =>
    GuardProjectSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardProjectSiteToJson(GuardProjectSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardProjectFilter _$GuardProjectFilterFromJson(Map<String, dynamic> json) =>
    GuardProjectFilter(
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardProjectFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardProjectFilterToJson(GuardProjectFilter instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
    };

GuardProjectFilterPetugas _$GuardProjectFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardProjectFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardProjectFilterPetugasToJson(
        GuardProjectFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
