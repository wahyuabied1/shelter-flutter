// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeOffResponse _$TimeOffResponseFromJson(Map<String, dynamic> json) =>
    TimeOffResponse(
      status: json['status'] as String?,
      waktu: json['waktu'] as String?,
      durasi: (json['durasi'] as num?)?.toInt(),
      keterangan: json['keterangan'] as String?,
      file: json['file'] == null
          ? null
          : FileClass.fromJson(json['file'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      berkas:
          (json['berkas'] as List<dynamic>?)?.map((e) => e as String).toList(),
      jenis: json['jenis'] as String?,
      pemohon: json['pemohon'] == null
          ? null
          : Pemohon.fromJson(json['pemohon'] as Map<String, dynamic>),
      reviewer: json['reviewer'] == null
          ? null
          : Pemohon.fromJson(json['reviewer'] as Map<String, dynamic>),
      review: json['review'] as String?,
      potongJatah: json['potong_jatah'] as bool?,
      potongJatahCuti: json['potong_jatah_cuti'] as bool?,
      site: json['site'] == null
          ? null
          : Site.fromJson(json['site'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TimeOffResponseToJson(TimeOffResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'waktu': instance.waktu,
      'durasi': instance.durasi,
      'keterangan': instance.keterangan,
      'file': instance.file,
      'location': instance.location,
      'berkas': instance.berkas,
      'jenis': instance.jenis,
      'pemohon': instance.pemohon,
      'reviewer': instance.reviewer,
      'review': instance.review,
      'potong_jatah': instance.potongJatah,
      'potong_jatah_cuti': instance.potongJatahCuti,
      'site': instance.site,
      'created_at': instance.createdAt?.toIso8601String(),
    };

FileClass _$FileClassFromJson(Map<String, dynamic> json) => FileClass(
      path: json['path'] as String?,
      ext: json['ext'] as String?,
    );

Map<String, dynamic> _$FileClassToJson(FileClass instance) => <String, dynamic>{
      'path': instance.path,
      'ext': instance.ext,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };

Pemohon _$PemohonFromJson(Map<String, dynamic> json) => Pemohon(
      nama: json['nama'] as String?,
      idPegawai: json['id_pegawai'] as String?,
      foto: json['foto'] as String?,
    );

Map<String, dynamic> _$PemohonToJson(Pemohon instance) => <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
    };

Site _$SiteFromJson(Map<String, dynamic> json) => Site(
      idSite: (json['id_site'] as num?)?.toInt(),
      nama: json['nama'] as String?,
    );

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'id_site': instance.idSite,
      'nama': instance.nama,
    };
