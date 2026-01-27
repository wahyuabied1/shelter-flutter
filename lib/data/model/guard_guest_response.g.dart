// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_guest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardGuestResponse _$GuardGuestResponseFromJson(Map<String, dynamic> json) =>
    GuardGuestResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardGuest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: GuardGuestFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardGuestResponseToJson(GuardGuestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardGuest _$GuardGuestFromJson(Map<String, dynamic> json) => GuardGuest(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardGuestPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      namaTamu: json['nama_tamu'] as String?,
      namaPerusahaan: json['nama_perusahaan'] as String?,
      tujuan: json['tujuan'] as String?,
      keperluan: json['keperluan'] as String?,
      shift: json['shift'] as String,
      masuk: json['masuk'] as String?,
      keluar: json['keluar'] as String?,
      departemen: json['departemen'] as String?,
      keterangan: json['keterangan'] as String?,
      photo:
          (json['photo'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$GuardGuestToJson(GuardGuest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'nama_tamu': instance.namaTamu,
      'nama_perusahaan': instance.namaPerusahaan,
      'tujuan': instance.tujuan,
      'keperluan': instance.keperluan,
      'shift': instance.shift,
      'masuk': instance.masuk,
      'keluar': instance.keluar,
      'departemen': instance.departemen,
      'keterangan': instance.keterangan,
      'photo': instance.photo,
    };

GuardGuestPetugas _$GuardGuestPetugasFromJson(Map<String, dynamic> json) =>
    GuardGuestPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardGuestSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardGuestPetugasToJson(GuardGuestPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardGuestSite _$GuardGuestSiteFromJson(Map<String, dynamic> json) =>
    GuardGuestSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardGuestSiteToJson(GuardGuestSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardGuestFilter _$GuardGuestFilterFromJson(Map<String, dynamic> json) =>
    GuardGuestFilter(
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardGuestFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardGuestFilterToJson(GuardGuestFilter instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'petugas': instance.petugas,
    };

GuardGuestFilterPetugas _$GuardGuestFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardGuestFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardGuestFilterPetugasToJson(
        GuardGuestFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
