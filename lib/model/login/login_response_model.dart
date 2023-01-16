import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_test_base/model/login/user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends Equatable {
  @JsonKey(name: "user")
  final UserModel userModel;
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "token_type")
  final String? tokenType;

  const LoginResponseModel({
    required this.userModel,
    this.accessToken,
    this.tokenType,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  List<Object?> get props {
    return [
      userModel,
      accessToken,
      tokenType,
    ];
  }
}
