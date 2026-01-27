import 'package:json_annotation/json_annotation.dart';

part 'hadirqu_overtime_submission_response.g.dart';

@JsonSerializable()
class HadirquOvertimeSubmissionResponse {
  @JsonKey(defaultValue: [])
  final List<OvertimeSubmission> data;
  final OvertimeSubmissionFilter filter;
  final String status;

  HadirquOvertimeSubmissionResponse({
    required this.data,
    required this.filter,
    required this.status,
  });

  factory HadirquOvertimeSubmissionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$HadirquOvertimeSubmissionResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$HadirquOvertimeSubmissionResponseToJson(this);
}

@JsonSerializable()
class OvertimeSubmission {
  final String status;
  final String tanggal;
  final String waktu;
  final String keterangan;
  final String durasi;
  final OvertimeLocation location;
  final List<OvertimeBerkas> berkas;
  final OvertimeSubmissionUser pemohon;
  final OvertimeReviewer? reviewer;

  OvertimeSubmission({
    required this.status,
    required this.tanggal,
    required this.waktu,
    required this.keterangan,
    required this.durasi,
    required this.location,
    required this.berkas,
    required this.pemohon,
    this.reviewer,
  });

  factory OvertimeSubmission.fromJson(Map<String, dynamic> json) {
    return OvertimeSubmission(
      status: json['status'] as String,
      tanggal: json['tanggal'] as String,
      waktu: json['waktu'] as String,
      keterangan: json['keterangan'] as String,
      durasi: json['durasi'] as String,
      location: OvertimeLocation.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      berkas: _parseBerkas(json['berkas']),
      pemohon: OvertimeSubmissionUser.fromJson(
        json['pemohon'] as Map<String, dynamic>,
      ),
      reviewer: json['reviewer'] == null
          ? null
          : OvertimeReviewer.fromJson(
              json['reviewer'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() => _$OvertimeSubmissionToJson(this);

  /// ✅ SAFE PARSER
  static List<OvertimeBerkas> _parseBerkas(dynamic value) {
    if (value == null) return [];

    // Case 1: List<Map>
    if (value is List) {
      return value
          .whereType<Map<String, dynamic>>()
          .map(OvertimeBerkas.fromJson)
          .toList();
    }

    // Case 2: Single String URL
    if (value is String) {
      return [
        OvertimeBerkas(
          mulai: value,
          selesai: value,
        )
      ];
    }

    return [];
  }
}

@JsonSerializable()
class OvertimeLocation {
  final LocationPoint mulai;
  final LocationPoint selesai;

  OvertimeLocation({
    required this.mulai,
    required this.selesai,
  });

  factory OvertimeLocation.fromJson(Map<String, dynamic> json) =>
      _$OvertimeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeLocationToJson(this);
}

@JsonSerializable()
class LocationPoint {
  final String lat;
  final String long;

  LocationPoint({
    required this.lat,
    required this.long,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    // Handle both String and int/double types from API
    return LocationPoint(
      lat: json['lat']?.toString() ?? '0',
      long: json['long']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() => _$LocationPointToJson(this);
}

@JsonSerializable()
class OvertimeBerkas {
  final String? mulai;
  final String? selesai;

  OvertimeBerkas({
    this.mulai,
    this.selesai,
  });

  factory OvertimeBerkas.fromJson(Map<String, dynamic> json) =>
      _$OvertimeBerkasFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeBerkasToJson(this);
}

@JsonSerializable()
class OvertimeSubmissionUser {
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final String? idPegawai;
  final String? foto;

  OvertimeSubmissionUser({
    required this.nama,
    this.idPegawai,
    this.foto,
  });

  factory OvertimeSubmissionUser.fromJson(Map<String, dynamic> json) =>
      _$OvertimeSubmissionUserFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeSubmissionUserToJson(this);
}

@JsonSerializable()
class OvertimeReviewer {
  final String nama;
  @JsonKey(name: 'id_pegawai')
  final String? idPegawai;
  final String? foto;
  final String? note;

  OvertimeReviewer({
    required this.nama,
    this.idPegawai,
    this.foto,
    this.note,
  });

  factory OvertimeReviewer.fromJson(Map<String, dynamic> json) =>
      _$OvertimeReviewerFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeReviewerToJson(this);
}

@JsonSerializable()
class OvertimeSubmissionFilter {
  @JsonKey(defaultValue: [])
  final List<OvertimeSubmissionDepartemen> departemen;
  @JsonKey(defaultValue: [])
  final List<OvertimeSubmissionStatus> status;

  OvertimeSubmissionFilter({
    required this.departemen,
    required this.status,
  });

  factory OvertimeSubmissionFilter.fromJson(Map<String, dynamic> json) =>
      _$OvertimeSubmissionFilterFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeSubmissionFilterToJson(this);
}

@JsonSerializable()
class OvertimeSubmissionDepartemen {
  final int id;
  final String nama;
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  OvertimeSubmissionDepartemen({
    required this.id,
    required this.nama,
    required this.totalPegawai,
  });

  factory OvertimeSubmissionDepartemen.fromJson(Map<String, dynamic> json) =>
      _$OvertimeSubmissionDepartemenFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeSubmissionDepartemenToJson(this);
}

@JsonSerializable()
class OvertimeSubmissionStatus {
  final int id;
  final String nama;

  OvertimeSubmissionStatus({
    required this.id,
    required this.nama,
  });

  factory OvertimeSubmissionStatus.fromJson(Map<String, dynamic> json) =>
      _$OvertimeSubmissionStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeSubmissionStatusToJson(this);
}
