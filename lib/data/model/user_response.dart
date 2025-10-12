import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "menus")
  final Menus? menus;

  UserResponse({
    this.token,
    this.user,
    this.menus,
  });

  UserResponse copyWith({
    String? token,
    User? user,
    Menus? menus,
  }) =>
      UserResponse(
        token: token ?? this.token,
        user: user ?? this.user,
        menus: menus ?? this.menus,
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  static String serialize(UserResponse model) =>
      json.encode(model.toJson());

  static UserResponse deserialize(String json) =>
      UserResponse.fromJson(jsonDecode(json));
}

@JsonSerializable()
class Menus {
  @JsonKey(name: "HadirKu")
  final bool? hadirKu;
  @JsonKey(name: "CleaningQu")
  final bool? cleaningQu;
  @JsonKey(name: "IssueQu")
  final bool? issueQu;
  @JsonKey(name: "Posko Patrol")
  final bool? poskoPatrol;

  Menus({
    this.hadirKu,
    this.cleaningQu,
    this.issueQu,
    this.poskoPatrol,
  });

  Menus copyWith({
    bool? hadirKu,
    bool? cleaningQu,
    bool? issueQu,
    bool? poskoPatrol,
  }) =>
      Menus(
        hadirKu: hadirKu ?? this.hadirKu,
        cleaningQu: cleaningQu ?? this.cleaningQu,
        issueQu: issueQu ?? this.issueQu,
        poskoPatrol: poskoPatrol ?? this.poskoPatrol,
      );

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "nama")
  final String? nama;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "foto")
  final String? foto;
  @JsonKey(name: "alamat")
  final String? alamat;
  @JsonKey(name: "site_ids")
  final List<int>? siteIds;
  @JsonKey(name: "role_ids")
  final List<int>? roleIds;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  User({
    this.id,
    this.nama,
    this.username,
    this.email,
    this.foto,
    this.alamat,
    this.siteIds,
    this.roleIds,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? nama,
    String? username,
    String? email,
    dynamic foto,
    dynamic alamat,
    List<int>? siteIds,
    List<int>? roleIds,
    String? createdAt,
    String? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        username: username ?? this.username,
        email: email ?? this.email,
        foto: foto ?? this.foto,
        alamat: alamat ?? this.alamat,
        siteIds: siteIds ?? this.siteIds,
        roleIds: roleIds ?? this.roleIds,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
