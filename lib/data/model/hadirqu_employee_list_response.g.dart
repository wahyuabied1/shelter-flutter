// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_employee_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadirquEmployeeListResponse _$HadirquEmployeeListResponseFromJson(
        Map<String, dynamic> json) =>
    HadirquEmployeeListResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: EmployeeFilter.fromJson(json['filter'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$HadirquEmployeeListResponseToJson(
        HadirquEmployeeListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filter': instance.filter,
      'status': instance.status,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      nama: json['nama'] as String,
      idPegawai: (json['id_pegawai'] as num?)?.toInt(),
      foto: json['foto'] as String,
      jabatan: json['jabatan'] as String?,
      namaSite: json['nama_site'] as String?,
      namaDepartemen: json['nama_departemen'] as String?,
      grup: json['grup'] as String?,
      jadwal: json['jadwal'] == null
          ? null
          : EmployeeJadwal.fromJson(json['jadwal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'nama': instance.nama,
      'id_pegawai': instance.idPegawai,
      'foto': instance.foto,
      'jabatan': instance.jabatan,
      'nama_site': instance.namaSite,
      'nama_departemen': instance.namaDepartemen,
      'grup': instance.grup,
      'jadwal': instance.jadwal,
    };

EmployeeJadwal _$EmployeeJadwalFromJson(Map<String, dynamic> json) =>
    EmployeeJadwal(
      nama: json['nama'] as String,
      detail: json['detail'] == null
          ? null
          : JadwalDetail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeJadwalToJson(EmployeeJadwal instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'detail': instance.detail,
    };

JadwalDetail _$JadwalDetailFromJson(Map<String, dynamic> json) => JadwalDetail(
      hari:
          (json['hari'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      jamMulai: json['jam_mulai'] as String?,
      jamSelesai: json['jam_selesai'] as String?,
      jamIstirahat: json['jam_istirahat'] as String?,
      jamIstirahatSelesai: json['jam_istirahat_selesai'] as String?,
    );

Map<String, dynamic> _$JadwalDetailToJson(JadwalDetail instance) =>
    <String, dynamic>{
      'hari': instance.hari,
      'jam_mulai': instance.jamMulai,
      'jam_selesai': instance.jamSelesai,
      'jam_istirahat': instance.jamIstirahat,
      'jam_istirahat_selesai': instance.jamIstirahatSelesai,
    };

EmployeeFilter _$EmployeeFilterFromJson(Map<String, dynamic> json) =>
    EmployeeFilter(
      jabatan: (json['jabatan'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      departemen: (json['departemen'] as List<dynamic>?)
              ?.map(
                  (e) => EmployeeDepartemen.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      grup: (json['grup'] as List<dynamic>?)
              ?.map((e) => EmployeeGrup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$EmployeeFilterToJson(EmployeeFilter instance) =>
    <String, dynamic>{
      'jabatan': instance.jabatan,
      'departemen': instance.departemen,
      'grup': instance.grup,
    };

EmployeeDepartemen _$EmployeeDepartemenFromJson(Map<String, dynamic> json) =>
    EmployeeDepartemen(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      totalPegawai: (json['total_pegawai'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeDepartemenToJson(EmployeeDepartemen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'total_pegawai': instance.totalPegawai,
    };

EmployeeGrup _$EmployeeGrupFromJson(Map<String, dynamic> json) => EmployeeGrup(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$EmployeeGrupToJson(EmployeeGrup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
    };
