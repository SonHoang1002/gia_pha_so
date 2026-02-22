import 'package:gia_pha_so/app/config/api_config.dart';
import 'package:gia_pha_so/route/routes.dart';
import 'package:gia_pha_so/src/data/datasource/auth_datasrc.dart';
import 'package:gia_pha_so/src/data/model/user_model.dart';
import 'package:gia_pha_so/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<dynamic> login(UserLoginDataModel data) async {
    return authDataSource.login(data.toJson());
  }

  @override
  Future<dynamic> register(UserRegisterDataModel data) async {
    return authDataSource.register(data.toJson());
  }
}
