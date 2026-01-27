// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_transporter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardTransporterResponse _$GuardTransporterResponseFromJson(
        Map<String, dynamic> json) =>
    GuardTransporterResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => GuardTransporter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filter: GuardTransporterFilter.fromJson(
          json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardTransporterResponseToJson(
        GuardTransporterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'filter': instance.filter,
    };

GuardTransporter _$GuardTransporterFromJson(Map<String, dynamic> json) =>
    GuardTransporter(
      id: (json['id'] as num).toInt(),
      tanggal: json['tanggal'] as String,
      petugas: GuardTransporterPetugas.fromJson(
          json['petugas'] as Map<String, dynamic>),
      jenisKendaraan: json['jenis_kendaraan'] as String?,
      noKendaraan: json['no_kendaraan'] as String?,
      perusahaanAngkutan: json['perusahaan_angkutan'] as String?,
      namaBarang: json['nama_barang'] as String?,
      sopir: json['sopir'] as String?,
      telpon: json['telpon'] as String?,
      masuk: json['masuk'] as String?,
      keluar: json['keluar'] as String?,
      keterangan: json['keterangan'] as String?,
      ktp: json['ktp'] as String?,
      suratJalan: json['surat_jalan'] as String?,
      noSurat: json['no_surat'] as String?,
      noContainer: json['no_container'] as String?,
    );

Map<String, dynamic> _$GuardTransporterToJson(GuardTransporter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tanggal': instance.tanggal,
      'petugas': instance.petugas,
      'jenis_kendaraan': instance.jenisKendaraan,
      'no_kendaraan': instance.noKendaraan,
      'perusahaan_angkutan': instance.perusahaanAngkutan,
      'nama_barang': instance.namaBarang,
      'sopir': instance.sopir,
      'telpon': instance.telpon,
      'masuk': instance.masuk,
      'keluar': instance.keluar,
      'keterangan': instance.keterangan,
      'ktp': instance.ktp,
      'surat_jalan': instance.suratJalan,
      'no_surat': instance.noSurat,
      'no_container': instance.noContainer,
    };

GuardTransporterPetugas _$GuardTransporterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardTransporterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      photo: json['photo'] as String?,
      site: GuardTransporterSite.fromJson(json['site'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardTransporterPetugasToJson(
        GuardTransporterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'photo': instance.photo,
      'site': instance.site,
    };

GuardTransporterSite _$GuardTransporterSiteFromJson(
        Map<String, dynamic> json) =>
    GuardTransporterSite(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardTransporterSiteToJson(
        GuardTransporterSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };

GuardTransporterFilter _$GuardTransporterFilterFromJson(
        Map<String, dynamic> json) =>
    GuardTransporterFilter(
      petugas: (json['petugas'] as List<dynamic>?)
              ?.map((e) => GuardTransporterFilterPetugas.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GuardTransporterFilterToJson(
        GuardTransporterFilter instance) =>
    <String, dynamic>{
      'petugas': instance.petugas,
    };

GuardTransporterFilterPetugas _$GuardTransporterFilterPetugasFromJson(
        Map<String, dynamic> json) =>
    GuardTransporterFilterPetugas(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
    );

Map<String, dynamic> _$GuardTransporterFilterPetugasToJson(
        GuardTransporterFilterPetugas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
