// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_presence_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquPresenceDetailResponse _$HadirquPresenceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquPresenceDetailResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PresenceMonth.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquPresenceDetailResponseToJson(
        HadirquPresenceDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

PresenceMonth _$PresenceMonthFromJson(Map<String, dynamic> json) =>
    PresenceMonth(
      bulan: json['bulan'] as String,
      tahun: json['tahun'] as String,
      bulanStr: json['bulan_str'] as String,
      detail: (json['detail'] as List<dynamic>)
          .map((e) => PresenceDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresenceMonthToJson(PresenceMonth instance) =>
    <String, dynamic>{
      'bulan': instance.bulan,
      'tahun': instance.tahun,
      'bulan_str': instance.bulanStr,
      'detail': instance.detail,
    };

PresenceDay _$PresenceDayFromJson(Map<String, dynamic> json) => PresenceDay(
      tanggal: json['tanggal'] as String,
      hari: json['hari'] as String,
      detail: (json['detail'] as List<dynamic>)
          .map((e) => PresenceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresenceDayToJson(PresenceDay instance) =>
    <String, dynamic>{
      'tanggal': instance.tanggal,
      'hari': instance.hari,
      'detail': instance.detail,
    };

PresenceItem _$PresenceItemFromJson(Map<String, dynamic> json) => PresenceItem(
      status: (json['status'] as num).toInt(),
      kode: json['kode'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$PresenceItemToJson(PresenceItem instance) =>
    <String, dynamic>{
      'status': instance.status,
      'kode': instance.kode,
      'text': instance.text,
    };
