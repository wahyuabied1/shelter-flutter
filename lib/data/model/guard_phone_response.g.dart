// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_phone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardPhoneResponse _$GuardPhoneResponseFromJson(Map<String, dynamic> json) =>
    GuardPhoneResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardPhone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: GuardPhoneFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardPhoneResponseToJson(GuardPhoneResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardPhone _$GuardPhoneFromJson(Map<String, dynamic> json) => GuardPhone(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardPhonePetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      namaPenelpon: json['nama_penelpon'] as String?,
      tujuan: json['tujuan'] as String?,
      keperluan: json['keperluan'] as String?,
      mulai: json['mulai'] as String?,
      selesai: json['selesai'] as String?,
      shift: json['shift'] as String,
    );

Map<String, dynamic> _$GuardPhoneToJson(GuardPhone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'nama_penelpon': instance.namaPenelpon,
      'tujuan': instance.tujuan,
      'keperluan': instance.keperluan,
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'shift': instance.shift,
    };

GuardPhonePetugas _$GuardPhonePetugasFromJson(Map<String, dynamic> json) =>
    GuardPhonePetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardPhoneSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardPhonePetugasToJson(GuardPhonePetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardPhoneSite _$GuardPhoneSiteFromJson(Map<String, dynamic> json) =>
    GuardPhoneSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardPhoneSiteToJson(GuardPhoneSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardPhoneFilter _$GuardPhoneFilterFromJson(Map<String, dynamic> json) =>
    GuardPhoneFilter(
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardPhoneFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardPhoneFilterToJson(GuardPhoneFilter instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'petugas': instance.petugas,
    };

GuardPhoneFilterPetugas _$GuardPhoneFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardPhoneFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardPhoneFilterPetugasToJson(
        GuardPhoneFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
