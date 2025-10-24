import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordReponse {
  @JsonKey(name: "new_token")
  final String? newToken;

  ChangePasswordReponse({
    this.newToken,
  });

  factory ChangePasswordReponse.fromJson(Map<String, dynamic> json) => _$ChangePasswordReponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordReponseToJson(this);
}
