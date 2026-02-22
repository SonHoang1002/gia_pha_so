import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<UserEntity> createUser({
    required String name,
    required String password,
    required String email,
  });
  Future<UserEntity?> getUserByEmailOrName({
    required String emailOrName,
    required String password,
  });
}
