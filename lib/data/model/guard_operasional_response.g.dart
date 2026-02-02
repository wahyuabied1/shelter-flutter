// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_operasional_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardOperasionalResponse _$GuardOperasionalResponseFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => GuardOperasional.fromJson(e as Map<String, dynamic>))
          .toList(),
      filter: json['filter'] == null
          ? null
          : GuardOperasionalFilter.fromJson(
              json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardOperasionalResponseToJson(
        GuardOperasionalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardOperasional _$GuardOperasionalFromJson(Map<String, dynamic> json) =>
    GuardOperasional(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      sopir:
          GuardOperasionalSopir.fromJson(json['sopir'] as Map<String, dynamic>),
      petugas: GuardOperasionalPetugas.fromJson(
          json['petugas'] as Map<String, dynamic>),
      kendaraan: GuardOperasionalKendaraan.fromJson(
          json['kendaraan'] as Map<String, dynamic>),
      kmMasuk: (json['km_masuk'] as num?)?.toInt(),
      kmKeluar: (json['km_keluar'] as num?)?.toInt(),
      jamMasuk: json['jam_masuk'] as String?,
      jamKeluar: json['jam_keluar'] as String?,
      keterangan: json['keterangan'] as String?,
      tujuan: json['tujuan'] as String?,
    );

Map<String, dynamic> _$GuardOperasionalToJson(GuardOperasional instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'sopir': instance.sopir,
      'petugas': instance.petugas,
      'kendaraan': instance.kendaraan,
      'km_masuk': instance.kmMasuk,
      'km_keluar': instance.kmKeluar,
      'jam_masuk': instance.jamMasuk,
      'jam_keluar': instance.jamKeluar,
      'keterangan': instance.keterangan,
      'tujuan': instance.tujuan,
    };

GuardOperasionalSopir _$GuardOperasionalSopirFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalSopir(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      noTelp: json['no_telp'] as String?,
    );

Map<String, dynamic> _$GuardOperasionalSopirToJson(
        GuardOperasionalSopir instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'no_telp': instance.noTelp,
    };

GuardOperasionalPetugas _$GuardOperasionalPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardOperasionalPetugasSite.fromJson(
          json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardOperasionalPetugasToJson(
        GuardOperasionalPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardOperasionalPetugasSite _$GuardOperasionalPetugasSiteFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalPetugasSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardOperasionalPetugasSiteToJson(
        GuardOperasionalPetugasSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardOperasionalKendaraan _$GuardOperasionalKendaraanFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalKendaraan(
      id: (json['id'] as num).toInt(),
      noPlat: json['no_plat'] as String,
    );

Map<String, dynamic> _$GuardOperasionalKendaraanToJson(
        GuardOperasionalKendaraan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no_plat': instance.noPlat,
    };

GuardOperasionalFilter _$GuardOperasionalFilterFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalFilter(
      kendaraan: (json['kendaraan'] as List<dynamic>)
          .map((e) => GuardOperasionalFilterKendaraan.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      petugas: (json['petugas'] as List<dynamic>)
          .map((e) =>
              GuardOperasionalFilterPetugas.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuardOperasionalFilterToJson(
        GuardOperasionalFilter instance) =>
    <String, dynamic>{
      'kendaraan': instance.kendaraan,
      'petugas': instance.petugas,
    };

GuardOperasionalFilterKendaraan _$GuardOperasionalFilterKendaraanFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalFilterKendaraan(
      id: (json['id'] as num).toInt(),
      noPlat: json['no_plat'] as String,
    );

Map<String, dynamic> _$GuardOperasionalFilterKendaraanToJson(
        GuardOperasionalFilterKendaraan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no_plat': instance.noPlat,
    };

GuardOperasionalFilterPetugas _$GuardOperasionalFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardOperasionalFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardOperasionalFilterPetugasToJson(
        GuardOperasionalFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
