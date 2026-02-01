import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserByName({
    required String name,
    required String password,
    required String email,
  });
  Future<UserEntity> createUser({
    required String name,
    required String password,
    required String email,
  });
}
