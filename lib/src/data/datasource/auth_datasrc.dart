import 'package:gia_pha_so/app/config/api_config.dart';
import 'package:gia_pha_so/route/routes.dart';

class AuthDataSource {
  Future<dynamic> login(Map<String, dynamic> json) async {
    return await Api.post(RouteNames.login, json);
  }

  Future<dynamic> register(Map<String, dynamic> json) async {
    return await Api.post(RouteNames.register, json);
  }
}
