// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_mail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardMailResponse _$GuardMailResponseFromJson(Map<String, dynamic> json) =>
    GuardMailResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardMail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: GuardMailFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardMailResponseToJson(GuardMailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardMail _$GuardMailFromJson(Map<String, dynamic> json) => GuardMail(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas:
          GuardMailPetugas.fromJson(json['petugas'] as Map<String, dynamic>),
      shift: json['shift'] as String,
      namaPengirim: json['nama_pengirim'] as String?,
      alamatPengirim: json['alamat_pengirim'] as String?,
      namaPenerima: json['nama_penerima'] as String?,
      jenisSurat: json['jenis_surat'] as String?,
      kurir: json['kurir'] as String?,
      noResi: json['no_resi'] as String?,
      jumlah: (json['jumlah'] as num?)?.toInt(),
      keterangan: json['keterangan'] as String?,
    );

Map<String, dynamic> _$GuardMailToJson(GuardMail instance) => <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'shift': instance.shift,
      'nama_pengirim': instance.namaPengirim,
      'alamat_pengirim': instance.alamatPengirim,
      'nama_penerima': instance.namaPenerima,
      'jenis_surat': instance.jenisSurat,
      'kurir': instance.kurir,
      'no_resi': instance.noResi,
      'jumlah': instance.jumlah,
      'keterangan': instance.keterangan,
    };

GuardMailPetugas _$GuardMailPetugasFromJson(Map<String, dynamic> json) =>
    GuardMailPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardMailSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardMailPetugasToJson(GuardMailPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardMailSite _$GuardMailSiteFromJson(Map<String, dynamic> json) =>
    GuardMailSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardMailSiteToJson(GuardMailSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardMailFilter _$GuardMailFilterFromJson(Map<String, dynamic> json) =>
    GuardMailFilter(
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) =>
                  GuardMailFilterPetugas.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shift: (json['shift'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardMailFilterToJson(GuardMailFilter instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
      'shift': instance.shift,
    };

GuardMailFilterPetugas _$GuardMailFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardMailFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardMailFilterPetugasToJson(
        GuardMailFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
