// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      menus: json['menus'] == null
          ? null
          : Menus.fromJson(json['menus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'menus': instance.menus,
    };

Menus _$MenusFromJson(Map<String, dynamic> json) => Menus(
      hadirKu: (json['HadirKu'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      cleaningQu: json['CleaningQu'] as bool?,
      issueQu: json['IssueQu'] as bool?,
      poskoPatrol: json['Posko Patrol'] as bool?,
    );

Map<String, dynamic> _$MenusToJson(Menus instance) => <String, dynamic>{
      'HadirKu': instance.hadirKu,
      'CleaningQu': instance.cleaningQu,
      'IssueQu': instance.issueQu,
      'Posko Patrol': instance.poskoPatrol,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      nama: json['nama'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      foto: json['foto'],
      alamat: json['alamat'],
      siteIds: (json['site_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      roleIds: (json['role_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'username': instance.username,
      'email': instance.email,
      'foto': instance.foto,
      'alamat': instance.alamat,
      'site_ids': instance.siteIds,
      'role_ids': instance.roleIds,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
