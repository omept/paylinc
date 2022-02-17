import 'dart:convert';

import 'package:paylinc/utils/services/rest_api_services.dart';

class ResponseModel {
  final Map? data;
  String? message;
  bool? status;
  int? statusCode;
  ResponseModel({
    this.data,
    this.message = RestApiServices.errMessage,
    this.status = false,
    this.statusCode,
  });

  ResponseModel copyWith({
    Map? data,
    String? message,
    bool? status,
    int? statusCode,
  }) {
    return ResponseModel(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'message': message,
      'status': status,
      'status_code': statusCode,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      data: map['data'] != null ? Map.from(map['data']) : null,
      message: map['message'] != null ? map['message'] : null,
      status: map['status'] != null ? map['status'] : null,
      statusCode: map['status_code'] != null ? map['status_code'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseModel(data: $data, message: $message, status: $status, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.data == data &&
        other.message == message &&
        other.status == status &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        message.hashCode ^
        status.hashCode ^
        statusCode.hashCode;
  }
}
