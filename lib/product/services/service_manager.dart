// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sneepy/product/constant/service.dart';
import 'package:sneepy/product/models/response_model.dart';

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

class ServiceManager {
  static final Dio _dio = Dio();
  static const String _baseUrl = ServiceConstants.baseUrl;
  static final Options _options = Options(
    headers: {
      'Authorization': 'Bearer ${ServiceConstants.token}',
    },
  );

  static Future<ResponseModel> makeRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    required RequestMethod method,
    File? file,
  }) async {
    try {
      Response response;

      FormData formData = FormData.fromMap(data ?? {});

      if (file != null) {
        formData.files
            .add(MapEntry('photo', await MultipartFile.fromFile(file.path)));
      }

      switch (method) {
        case RequestMethod.GET:
          response = await _dio.get(
            '$_baseUrl/$endpoint',
            queryParameters: params,
            options: _options,
          );
          break;
        case RequestMethod.POST:
          response = await _dio.post(
            '$_baseUrl/$endpoint',
            data: data ?? formData,
            queryParameters: params,
            options: _options,
          );
          break;
        case RequestMethod.PUT:
          response = await _dio.put(
            '$_baseUrl/$endpoint',
            data: data ?? formData,
            queryParameters: params,
            options: _options,
          );
          break;
        case RequestMethod.DELETE:
          response = await _dio.delete(
            '$_baseUrl/$endpoint',
            data: data,
            queryParameters: params,
            options: _options,
          );
          break;
        default:
          throw Exception('Bir hata oluştu...');
      }

      if (kDebugMode) {
        print(response.data);
      }

      final Map<String, dynamic> json = response.data;
      final jsonResponse = ResponseModel.fromJson(json);
      return jsonResponse;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      if (kDebugMode) {
        print('Error: $e');
      }
      return ResponseModel.fromJson(e.response?.data ?? {});
    }
  }
}
