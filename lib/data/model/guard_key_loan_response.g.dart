// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_key_loan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardKeyLoanResponse _$GuardKeyLoanResponseFromJson(
        Map<String, dynamic> json) =>
    GuardKeyLoanResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardKeyLoan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter:
          GuardKeyLoanFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardKeyLoanResponseToJson(
        GuardKeyLoanResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardKeyLoan _$GuardKeyLoanFromJson(Map<String, dynamic> json) => GuardKeyLoan(
      id: (json['id'] as num).toInt(),
      petugas:
          GuardKeyLoanPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      shift: json['shift'] as String,
      ruang: GuardKeyLoanRuang.fromJson(json['ruang'] as Map<String, dynamic>),
      tanggal: json['tanggal'] as String,
      jamAmbil: json['jam_ambil'] as String?,
      jamKembali: json['jam_kembali'] as String?,
      peminjam: json['peminjam'] as String?,
      pengembali: json['pengembali'] as String?,
    );

Map<String, dynamic> _$GuardKeyLoanToJson(GuardKeyLoan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petugas': instance.petugas,
      'shift': instance.shift,
      'ruang': instance.ruang,
      'tanggal': instance.tanggal,
      'jam_ambil': instance.jamAmbil,
      'jam_kembali': instance.jamKembali,
      'peminjam': instance.peminjam,
      'pengembali': instance.pengembali,
    };

GuardKeyLoanPetugas _$GuardKeyLoanPetugasFromJson(Map<String, dynamic> json) =>
    GuardKeyLoanPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardKeyLoanSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardKeyLoanPetugasToJson(
        GuardKeyLoanPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardKeyLoanSite _$GuardKeyLoanSiteFromJson(Map<String, dynamic> json) =>
    GuardKeyLoanSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardKeyLoanSiteToJson(GuardKeyLoanSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardKeyLoanRuang _$GuardKeyLoanRuangFromJson(Map<String, dynamic> json) =>
    GuardKeyLoanRuang(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardKeyLoanRuangToJson(GuardKeyLoanRuang instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardKeyLoanFilter _$GuardKeyLoanFilterFromJson(Map<String, dynamic> json) =>
    GuardKeyLoanFilter(
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      ruangan: (json['ruangan'] as List<dynamic>?)
              ?.map((e) =>
                  GuardKeyLoanFilterRuangan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardKeyLoanFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardKeyLoanFilterToJson(GuardKeyLoanFilter instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'ruangan': instance.ruangan,
      'petugas': instance.petugas,
    };

GuardKeyLoanFilterRuangan _$GuardKeyLoanFilterRuanganFromJson(
        Map<String, dynamic> json) =>
    GuardKeyLoanFilterRuangan(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardKeyLoanFilterRuanganToJson(
        GuardKeyLoanFilterRuangan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardKeyLoanFilterPetugas _$GuardKeyLoanFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardKeyLoanFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardKeyLoanFilterPetugasToJson(
        GuardKeyLoanFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
