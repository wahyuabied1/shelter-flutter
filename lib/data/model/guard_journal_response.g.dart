// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_journal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardJournalResponse _$GuardJournalResponseFromJson(
        Map<String, dynamic> json) =>
    GuardJournalResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardJournal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter:
          GuardJournalFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardJournalResponseToJson(
        GuardJournalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardJournal _$GuardJournalFromJson(Map<String, dynamic> json) => GuardJournal(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardJournalPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      shift: json['shift'] as String,
      mulai: json['mulai'] as String?,
      selesai: json['selesai'] as String?,
      laporan: json['laporan'] as String?,
      listPetugas: json['list_petugas'] as String?,
    );

Map<String, dynamic> _$GuardJournalToJson(GuardJournal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'shift': instance.shift,
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'laporan': instance.laporan,
      'list_petugas': instance.listPetugas,
    };

GuardJournalPetugas _$GuardJournalPetugasFromJson(Map<String, dynamic> json) =>
    GuardJournalPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardJournalSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardJournalPetugasToJson(
        GuardJournalPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardJournalSite _$GuardJournalSiteFromJson(Map<String, dynamic> json) =>
    GuardJournalSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardJournalSiteToJson(GuardJournalSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardJournalFilter _$GuardJournalFilterFromJson(Map<String, dynamic> json) =>
    GuardJournalFilter(
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardJournalFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardJournalFilterToJson(GuardJournalFilter instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
      'shift': instance.shift,
    };

GuardJournalFilterPetugas _$GuardJournalFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardJournalFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardJournalFilterPetugasToJson(
        GuardJournalFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
