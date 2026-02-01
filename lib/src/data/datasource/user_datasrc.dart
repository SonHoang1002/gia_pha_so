import 'package:gia_pha_so/app/util/asset_util.dart';
import 'package:gia_pha_so/src/data/model/user_model.dart';

class UserDataSource {
  Future<UserModel> getUserByUser({
    required String name,
    required String password,
    required String email,
  }) async {
    final result = await AssetUtil.loadJson("users.json");
    return UserModel.fromJson(result);
  }

  Future<dynamic> createUser({
    required String name,
    required String password,
    required String email,
  }) async {
    var data = await AssetUtil.loadJsonList("users.json");
    final newUser = UserModel(name: name, password: password, email: email);
    data.add(newUser.toJson());
    return newUser;
  }
}
