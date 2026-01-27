// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardNewsResponse _$GuardNewsResponseFromJson(Map<String, dynamic> json) =>
    GuardNewsResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardNews.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: GuardNewsFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardNewsResponseToJson(GuardNewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardNews _$GuardNewsFromJson(Map<String, dynamic> json) => GuardNews(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardNewsPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      shift: json['shift'] as String,
      namaPelapor: json['nama_pelapor'] as String?,
      temuan: json['temuan'] as String?,
      tindakan: json['tindakan'] as String?,
      diketahui: json['diketahui'] as String?,
    );

Map<String, dynamic> _$GuardNewsToJson(GuardNews instance) => <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'shift': instance.shift,
      'nama_pelapor': instance.namaPelapor,
      'temuan': instance.temuan,
      'tindakan': instance.tindakan,
      'diketahui': instance.diketahui,
    };

GuardNewsPetugas _$GuardNewsPetugasFromJson(Map<String, dynamic> json) =>
    GuardNewsPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardNewsSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardNewsPetugasToJson(GuardNewsPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardNewsSite _$GuardNewsSiteFromJson(Map<String, dynamic> json) =>
    GuardNewsSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardNewsSiteToJson(GuardNewsSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardNewsFilter _$GuardNewsFilterFromJson(Map<String, dynamic> json) =>
    GuardNewsFilter(
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardNewsFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardNewsFilterToJson(GuardNewsFilter instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
      'shift': instance.shift,
    };

GuardNewsFilterPetugas _$GuardNewsFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardNewsFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardNewsFilterPetugasToJson(
        GuardNewsFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
