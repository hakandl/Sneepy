// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/init/network/network_control.dart';
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
  final String? _token = HiveManager.get(key: BoxKeyNames.token.name);
  final String? _locale = HiveManager.get(key: BoxKeyNames.locale.name);
  Options options() {
    final headers = {
      'Authorization': 'Bearer $_token',
      'Accept-Language': _locale,
    };
    return Options(headers: headers);
  }

  static Future<ResponseModel> makeRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    required RequestMethod method,
    File? file,
  }) async {
    final isConnected = await NetworkControl.isInternetConnected();
    if (!isConnected) {
      await NetworkControl.showNoInternetDialog();
      return ResponseModel();
    }

    try {
      final options = ServiceManager().options();
      Response response;
      FormData formData = FormData.fromMap(data ?? {});

      if (file != null) {
        formData.files.add(
          MapEntry(
            ServiceConstants.photo,
            await MultipartFile.fromFile(file.path),
          ),
        );
      }

      switch (method) {
        case RequestMethod.GET:
          response = await _dio.get(
            '$_baseUrl/$endpoint',
            queryParameters: params,
            options: options,
          );
          break;
        case RequestMethod.POST:
          response = await _dio.post(
            '$_baseUrl/$endpoint',
            data: data ?? formData,
            queryParameters: params,
            options: options,
          );
          break;
        case RequestMethod.PUT:
          response = await _dio.put(
            '$_baseUrl/$endpoint',
            data: data ?? formData,
            queryParameters: params,
            options: options,
          );
          break;
        case RequestMethod.DELETE:
          response = await _dio.delete(
            '$_baseUrl/$endpoint',
            data: data,
            queryParameters: params,
            options: options,
          );
          break;
        default:
          throw Exception(LocaleKeys.thereIsProblem.tr());
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
