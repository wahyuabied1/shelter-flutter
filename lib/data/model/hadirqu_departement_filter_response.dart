import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_departement_filter_response.g.dart';

@JsonSerializable()
class Departemen {
  final int id;
  final String nama;
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  Departemen({
    required this.id,
    required this.nama,
    required this.totalPegawai,
  });

  factory Departemen.fromJson(Map<String, dynamic> json) =>
      _$DepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$DepartemenToJson(this);
}
