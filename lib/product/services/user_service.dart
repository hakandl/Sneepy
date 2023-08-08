import 'package:sneepy/product/constants/endpoints.dart';
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
}
