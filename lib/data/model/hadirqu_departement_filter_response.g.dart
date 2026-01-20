// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadirqu_departement_filter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departemen _$DepartemenFromJson(Map<String, dynamic> json) => Departemen(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      totalPegawai: (json['total_pegawai'] as num).toInt(),
    );

Map<String, dynamic> _$DepartemenToJson(Departemen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'total_pegawai': instance.totalPegawai,
    };
