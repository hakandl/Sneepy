import 'dart:io';

import 'package:sneepy/product/constant/endpoints.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/service_manager.dart';

class AuthService {
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
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
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
  }) async {
    final Map<String, dynamic> data = {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      'age': age,
      'gender': gender,
      'country': country,
      'snapchat': snapchat,
      'instagram': instagram,
      'twitter': twitter,
    };

    final response = await ServiceManager.makeRequest(
      method: RequestMethod.PUT,
      endpoint: ApiEndpoints.me,
      data: data,
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
    String? photoId,
  }) async {
    final response = await ServiceManager.makeRequest(
      endpoint: '${ApiEndpoints.photos}/$photoId',
      method: RequestMethod.PUT,
      file: File(file.path),
    );
    return response;
  }
}
