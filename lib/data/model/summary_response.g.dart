// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponse _$SummaryResponseFromJson(Map<String, dynamic> json) =>
    SummaryResponse(
      type: json['type'] as String?,
      total: json['total'] as String?,
      done: json['done'] as String?,
      notYet: json['notYet'] as String?,
      percentage: json['percentage'] as String?,
    );

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'total': instance.total,
      'done': instance.done,
      'notYet': instance.notYet,
      'percentage': instance.percentage,
    };
