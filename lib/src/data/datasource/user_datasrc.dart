import 'package:gia_pha_so/app/util/asset_util.dart';
import 'package:gia_pha_so/src/data/model/user_model.dart';

class UserDataSource {
  Future<List<UserModel>> getUsers() async {
    final result = await AssetUtil.load("users.json");
    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel?> getUserByUser({
    required String emailOrName,
    required String password,
  }) async {
    List<UserModel> allUser = await getUsers();
    UserModel? target = allUser.where((element) {
      return element.password == password ||
          (element.name == emailOrName || element.email == emailOrName);
    }).firstOrNull;
    return target;
  }

  Future<dynamic> createUser({
    required String name,
    required String password,
    required String email,
  }) async {
   
    final newUser = UserModel(name: name, password: password, email: email);
   
    return newUser;
  }
}
