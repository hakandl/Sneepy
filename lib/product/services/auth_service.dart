import 'dart:io';

import 'package:sneepy/product/constants/endpoints.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/manager/service_manager.dart';

class AuthService {
  Future<ResponseModel> checkAuth() async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.checkAuth,
    );
    return response;
  }

  Future<ResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  Future<ResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'deviceToken': deviceToken,
      },
    );
    return response;
  }

  Future<UserModel> getMe() async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.me,
    );
    final jsonResponse = UserModel.fromJson(response.data);
    return jsonResponse;
  }

  Future<ResponseModel> updateMe({
    String? name,
    String? email,
    String? password,
    String? age,
    String? gender,
    String? country,
    String? snapchat,
    String? instagram,
    String? twitter,
    String? deviceToken,
  }) async {
    final Map<String, dynamic> data = {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (country != null) 'country': country,
      if (snapchat != null) 'snapchat': snapchat,
      if (instagram != null) 'instagram': instagram,
      if (twitter != null) 'twitter': twitter,
      if (deviceToken != null) 'deviceToken': deviceToken,
    };

    final response = await ServiceManager.makeRequest(
      method: RequestMethod.PUT,
      endpoint: ApiEndpoints.me,
      data: data,
    );
    return response;
  }

  Future<ResponseModel> deleteMe() async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.DELETE,
      endpoint: ApiEndpoints.me,
    );
    return response;
  }

  Future<ResponseModel> addPhoto({
    required File file,
  }) async {
    final response = await ServiceManager.makeRequest(
      endpoint: ApiEndpoints.photos,
      method: RequestMethod.POST,
      file: File(file.path),
    );
    return response;
  }

  Future<ResponseModel> updatePhoto({
    required File file,
    required String photoId,
  }) async {
    final response = await ServiceManager.makeRequest(
      endpoint: '${ApiEndpoints.photos}/$photoId',
      method: RequestMethod.PUT,
      file: File(file.path),
    );
    return response;
  }

  Future<ResponseModel> deletePhoto({
    required String photoId,
  }) async {
    final response = await ServiceManager.makeRequest(
      endpoint: '${ApiEndpoints.photos}/$photoId',
      method: RequestMethod.DELETE,
    );
    return response;
  }
}
