import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tune_pulse/app/modules/shared/general_dialog.dart';
import 'package:tune_pulse/app/services/network/api_exception.dart';
import 'package:tune_pulse/app/services/network/http_error.dart';
import 'package:tune_pulse/app/services/storage/local_storage.dart';

class HttpCrudClient {
  static String baseUrl = "https://api.deezer.com/";

  Future<Map<String, String>?> headers({bool? login}) async {
    Map<String, String>? headers = {};
    headers["Content-Type"] = 'application/json; charset=UTF-8';
    headers["accept"] = 'application/json; charset=UTF-8';
    headers['X-RapidAPI-Key'] =
        "25ccd6689emsh16f04e411d2987bp14c763jsn5dada2b38f67";
    headers['X-RapidAPI-Host'] = "deezerdevs-deezer.p.rapidapi.com";
    return headers;
  }

  Future<dynamic> get(String url) async {
    final String uri = "$baseUrl$url";
    dynamic responseJson;
    final headers = await this.headers();
    try {
      debugPrint(uri);
      final response = await http.get(Uri.parse(uri), headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Object body, [bool? file]) async {
    final String uri = "$baseUrl$url";

    Map<String, String>? headers = await this.headers();

    try {
      var data = json.encode(body);
      if (file == true) {
        final request = http.MultipartRequest("POST", Uri.parse(uri));
        request.headers.addAll(headers!);
        request.files.add(
          await http.MultipartFile.fromPath('file', body.toString()),
        );
        final streamResponse = await request.send();
        final response = await http.Response.fromStream(streamResponse);
        return _response(response);
      } else {
        final response = await http.post(
          Uri.parse(uri),
          headers: headers,
          body: data,
        );
        debugPrint("activity test $uri $data");
        return _response(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    final String uri = "$baseUrl$url";
    dynamic responseJson;
    final headers = await this.headers();
    try {
      var data = json.encode(body);
      final response =
          await http.put(Uri.parse(uri), headers: headers, body: data);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, Map<String, dynamic> body) async {
    final String uri = "$baseUrl$url";
    dynamic responseJson;
    final headers = await this.headers();
    try {
      var data = json.encode(body);
      final response =
          await http.patch(Uri.parse(uri), headers: headers, body: data);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, Map<String, dynamic> body) async {
    final String uri = "$baseUrl$url";
    dynamic responseJson;
    final headers = await this.headers();
    try {
      var data = json.encode(body);
      final response =
          await http.delete(Uri.parse(uri), headers: headers, body: data);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = (json.decode(response.body.toString()));
        return responseJson;
      case 400:
      case 401:
      case 422:
        var responseJson = (json.decode(response.body.toString()));
        final HttpError httpError = HttpError.fromJson(responseJson);
        GeneralAlertDialog.showAlertDialog(httpError.message);
        throw BadRequestException(response.body.toString());
      case 403:
        var responseJson = (json.decode(response.body.toString()));
        final HttpError httpError = HttpError.fromJson(responseJson);
        GeneralAlertDialog.showAlertDialog(httpError.message,
            navigateToLogin: true);
        await sharedPref.clear();
        throw UnauthorisedException(response.body.toString());
      case 413:
        GeneralAlertDialog.showAlertDialog(response.reasonPhrase.toString());
        throw BadRequestException(response.reasonPhrase..toString());
      case 500:
        var responseJson = (json.decode(response.body.toString()));
        final HttpError httpError = HttpError.fromJson(responseJson);
        GeneralAlertDialog.showAlertDialog(httpError.message);
        throw BadRequestException(response.body.toString());

      default:
        var responseJson = (json.decode(response.body.toString()));
        final HttpError httpError = HttpError.fromJson(responseJson);
        GeneralAlertDialog.showAlertDialog(httpError.message);
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
