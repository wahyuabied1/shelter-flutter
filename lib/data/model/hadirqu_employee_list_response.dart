import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_employee_list_response.g.dart';

@JsonSerializable()
class HadirquEmployeeListResponse {
  @JsonKey(defaultValue: [])
  final List<Employee> data;
  final EmployeeFilter filter;
  final String status;

  HadirquEmployeeListResponse({
    required this.data,
    required this.filter,
    required this.status,
  });

  factory HadirquEmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      _$HadirquEmployeeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HadirquEmployeeListResponseToJson(this);
}

@JsonSerializable()
class Employee {
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final int? idPegawai;
  final String foto;
  final String? jabatan;
  @JsonKey(name: 'nama_site')
  final String? namaSite;
  @JsonKey(name: 'nama_departemen')
  final String? namaDepartemen;
  final String? grup;
  final EmployeeJadwal? jadwal;

  Employee({
    required this.nama,
    this.idPegawai,
    required this.foto,
    this.jabatan,
    this.namaSite,
    this.namaDepartemen,
    this.grup,
    this.jadwal,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class EmployeeJadwal {
  final String nama;
  final JadwalDetail? detail;

  EmployeeJadwal({
    required this.nama,
    this.detail,
  });

  factory EmployeeJadwal.fromJson(Map<String, dynamic> json) =>
      _$EmployeeJadwalFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeJadwalToJson(this);
}

@JsonSerializable()
class JadwalDetail {
  @JsonKey(defaultValue: []) // ✅ Default empty list
  final List<String> hari;
  @JsonKey(name: 'jam_mulai')
  final String? jamMulai;
  @JsonKey(name: 'jam_selesai')
  final String? jamSelesai;
  @JsonKey(name: 'jam_istirahat')
  final String? jamIstirahat;
  @JsonKey(name: 'jam_istirahat_selesai')
  final String? jamIstirahatSelesai;

  JadwalDetail({
    required this.hari,
    this.jamMulai,
    this.jamSelesai,
    this.jamIstirahat,
    this.jamIstirahatSelesai,
  });

  factory JadwalDetail.fromJson(Map<String, dynamic> json) =>
      _$JadwalDetailFromJson(json);

  Map<String, dynamic> toJson() => _$JadwalDetailToJson(this);
}

@JsonSerializable()
class EmployeeFilter {
  @JsonKey(defaultValue: [])
  final List<String> jabatan;
  @JsonKey(defaultValue: [])
  final List<EmployeeDepartemen> departemen;
  @JsonKey(defaultValue: [])
  final List<EmployeeGrup> grup;

  EmployeeFilter({
    required this.jabatan,
    required this.departemen,
    required this.grup,
  });

  factory EmployeeFilter.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeFilterToJson(this);
}

@JsonSerializable()
class EmployeeDepartemen {
  final int id;
  final String nama;
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  EmployeeDepartemen({
    required this.id,
    required this.nama,
    required this.totalPegawai,
  });

  factory EmployeeDepartemen.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDepartemenToJson(this);
}

@JsonSerializable()
class EmployeeGrup {
  final int id;
  final String text;

  EmployeeGrup({
    required this.id,
    required this.text,
  });

  factory EmployeeGrup.fromJson(Map<String, dynamic> json) =>
      _$EmployeeGrupFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeGrupToJson(this);
}
