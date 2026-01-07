import 'package:json_annotation/json_annotation.dart';

part 'time_off_response.g.dart';

@JsonSerializable()
class TimeOffResponse {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "waktu")
  final String? waktu;
  @JsonKey(name: "durasi")
  final int? durasi;
  @JsonKey(name: "keterangan")
  final String? keterangan;
  @JsonKey(name: "file")
  final FileClass? file;
  @JsonKey(name: "location")
  final Location? location;
  @JsonKey(name: "berkas")
  final List<String>? berkas;
  @JsonKey(name: "jenis")
  final String? jenis;
  @JsonKey(name: "pemohon")
  final Pemohon? pemohon;
  @JsonKey(name: "reviewer")
  final Pemohon? reviewer;
  @JsonKey(name: "review")
  final String? review;
  @JsonKey(name: "potong_jatah")
  final bool? potongJatah;
  @JsonKey(name: "potong_jatah_cuti")
  final bool? potongJatahCuti;
  @JsonKey(name: "site")
  final Site? site;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  TimeOffResponse({
    this.status,
    this.waktu,
    this.durasi,
    this.keterangan,
    this.file,
    this.location,
    this.berkas,
    this.jenis,
    this.pemohon,
    this.reviewer,
    this.review,
    this.potongJatah,
    this.potongJatahCuti,
    this.site,
    this.createdAt,
  });

  TimeOffResponse copyWith({
    String? status,
    String? waktu,
    int? durasi,
    String? keterangan,
    FileClass? file,
    Location? location,
    List<String>? berkas,
    String? jenis,
    Pemohon? pemohon,
    Pemohon? reviewer,
    String? review,
    bool? potongJatah,
    bool? potongJatahCuti,
    Site? site,
    DateTime? createdAt,
  }) =>
      TimeOffResponse(
        status: status ?? this.status,
        waktu: waktu ?? this.waktu,
        durasi: durasi ?? this.durasi,
        keterangan: keterangan ?? this.keterangan,
        file: file ?? this.file,
        location: location ?? this.location,
        berkas: berkas ?? this.berkas,
        jenis: jenis ?? this.jenis,
        pemohon: pemohon ?? this.pemohon,
        reviewer: reviewer ?? this.reviewer,
        review: review ?? this.review,
        potongJatah: potongJatah ?? this.potongJatah,
        potongJatahCuti: potongJatahCuti ?? this.potongJatahCuti,
        site: site ?? this.site,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TimeOffResponse.fromJson(Map<String, dynamic> json) => _$TimeOffResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeOffResponseToJson(this);
}

@JsonSerializable()
class FileClass {
  @JsonKey(name: "path")
  final String? path;
  @JsonKey(name: "ext")
  final String? ext;

  FileClass({
    this.path,
    this.ext,
  });

  FileClass copyWith({
    String? path,
    String? ext,
  }) =>
      FileClass(
        path: path ?? this.path,
        ext: ext ?? this.ext,
      );

  factory FileClass.fromJson(Map<String, dynamic> json) => _$FileClassFromJson(json);

  Map<String, dynamic> toJson() => _$FileClassToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  Location({
    this.lat,
    this.long,
  });

  Location copyWith({
    String? lat,
    String? long,
  }) =>
      Location(
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Pemohon {
  @JsonKey(name: "nama")
  final String? nama;
  @JsonKey(name: "id_pegawai")
  final String? idPegawai;
  @JsonKey(name: "foto")
  final String? foto;

  Pemohon({
    this.nama,
    this.idPegawai,
    this.foto,
  });

  Pemohon copyWith({
    String? nama,
    String? idPegawai,
    String? foto,
  }) =>
      Pemohon(
        nama: nama ?? this.nama,
        idPegawai: idPegawai ?? this.idPegawai,
        foto: foto ?? this.foto,
      );

  factory Pemohon.fromJson(Map<String, dynamic> json) => _$PemohonFromJson(json);

  Map<String, dynamic> toJson() => _$PemohonToJson(this);
}

@JsonSerializable()
class Site {
  @JsonKey(name: "id_site")
  final int? idSite;
  @JsonKey(name: "nama")
  final String? nama;

  Site({
    this.idSite,
    this.nama,
  });

  Site copyWith({
    int? idSite,
    String? nama,
  }) =>
      Site(
        idSite: idSite ?? this.idSite,
        nama: nama ?? this.nama,
      );

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  Map<String, dynamic> toJson() => _$SiteToJson(this);
}
