import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_test_base/core/data/model/failure.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  final T? data;
  final String? message;
  @JsonKey(name: "status_code")
  final int? statusCode;
  final String? status;

  const ApiResponse( {
    this.data,
    this.message,
    this.statusCode,
    this.status,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  bool get isSuccess => data != null;

  T getValue() {
    if (isSuccess) {
      return data!;
    }
    throw Failure(message: message!, code: statusCode);
  }

  @override
  List<Object?> get props => [status, statusCode, message, data];

  @override
  bool get stringify => true;
}