import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'summary_response.g.dart';

@JsonSerializable()
class SummaryResponse {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "total")
  final String? total;
  @JsonKey(name: "done")
  final String? done;
  @JsonKey(name: "notYet")
  final String? notYet;
  @JsonKey(name: "percentage")
  final String? percentage;

  SummaryResponse({
    this.type,
    this.total,
    this.done,
    this.notYet,
    this.percentage,
  });

  SummaryResponse copyWith({
    String? type,
    String? total,
    String? done,
    String? notYet,
    String? percentage,
  }) =>
      SummaryResponse(
        type: type ?? this.type,
        total: total ?? this.total,
        done: done ?? this.done,
        notYet: notYet ?? this.notYet,
        percentage: percentage ?? this.percentage,
      );

  factory SummaryResponse.fromJson(Map<String, dynamic> json) => _$SummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryResponseToJson(this);

  static String serialize(SummaryResponse model) =>
      json.encode(model.toJson());

  static SummaryResponse deserialize(String json) =>
      SummaryResponse.fromJson(jsonDecode(json));
}
