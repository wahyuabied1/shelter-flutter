import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_presence_detail_response.g.dart';

@JsonSerializable()
class HadirquPresenceDetailResponse {
  final List<PresenceMonth> data;
  final String status;

  HadirquPresenceDetailResponse({
    required this.data,
    required this.status,
  });

  factory HadirquPresenceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquPresenceDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquPresenceDetailResponseToJson(this);
}

@JsonSerializable()
class PresenceMonth {
  final String bulan;
  final String tahun;

  @JsonKey(name: 'bulan_str')
  final String bulanStr;

  final List<PresenceDay> detail;

  PresenceMonth({
    required this.bulan,
    required this.tahun,
    required this.bulanStr,
    required this.detail,
  });

  factory PresenceMonth.fromJson(Map<String, dynamic> json) =>
      _$PresenceMonthFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceMonthToJson(this);
}

@JsonSerializable()
class PresenceDay {
  final String tanggal;
  final String hari;

  final List<PresenceItem> detail;

  PresenceDay({
    required this.tanggal,
    required this.hari,
    required this.detail,
  });

  factory PresenceDay.fromJson(Map<String, dynamic> json) =>
      _$PresenceDayFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceDayToJson(this);
}

@JsonSerializable()
class PresenceItem {
  final int status;
  final String kode;
  final String text;

  PresenceItem({
    required this.status,
    required this.kode,
    required this.text,
  });

  factory PresenceItem.fromJson(Map<String, dynamic> json) =>
      _$PresenceItemFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceItemToJson(this);
}
