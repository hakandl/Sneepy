import 'package:sneepy/product/constant/endpoints.dart';
import 'package:sneepy/product/models/response_model.dart';
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
    String? age,
    String? gender,
    String? country,
    String? snapchat,
    String? instagram,
    String? twitter,
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'age': age,
        'gender': gender,
        'country': country,
        'snapchat': snapchat,
        'instagram': instagram,
        'twitter': twitter,
      },
    );
    return response;
  }
}
