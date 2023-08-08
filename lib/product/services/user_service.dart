import 'package:sneepy/product/constants/endpoints.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/service_manager.dart';

class UserService {
  Future<List<UserModel>> getUsers() async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.users,
    );
    final List jsonResponse = response.data;
    final users = jsonResponse.map((e) => UserModel.fromJson(e)).toList();
    return users;
  }

  Future<ResponseModel> sendFriendRequest({
    required String userId,
    required int sentType,
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint: '${ApiEndpoints.sendFriendRequest}/$userId/$sentType',
    );
    return response;
  }

  Future<ResponseModel> skipFriendRequest({
    required String userId,
  }) async {
    final response = await ServiceManager.makeRequest(
      method: RequestMethod.POST,
      endpoint:
          '${ApiEndpoints.users}/${ApiEndpoints.skipFriendRequest}/$userId',
    );
    return response;
  }
}
