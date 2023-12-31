// To parse this JSON data, do
//
//     final httpError = httpErrorFromJson(jsonString);

import 'dart:convert';

class HttpError {
    final int code;
    final String message;
    final bool success;

    HttpError({
        required this.code,
        required this.message,
        required this.success,
    });

    HttpError copyWith({
        int? code,
        String? message,
        bool? success,
    }) => 
        HttpError(
            code: code ?? this.code,
            message: message ?? this.message,
            success: success ?? this.success,
        );

    factory HttpError.fromRawJson(String str) => HttpError.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HttpError.fromJson(Map<String, dynamic> json) => HttpError(
        code: json["code"],
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
    };
}
