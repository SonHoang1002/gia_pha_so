import 'package:gia_pha_so/src/data/datasource/user_datasrc.dart';
import 'package:gia_pha_so/src/data/model/user_model.dart';
import 'package:gia_pha_so/src/domain/entity/user_entity.dart';
import 'package:gia_pha_so/src/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<UserEntity> createUser({
    required String name,
    required String password,
    required String email,
  }) async {
    final userModel = await userDataSource.createUser(
      name: name,
      password: password,
      email: email,
    );
    return userModel.toEntity;
  }

  @override
  Future<UserEntity?> getUserByEmailOrName({
    required String emailOrName,
    required String password, 
  }) async {
    final userModel = await userDataSource.getUserByUser(
      emailOrName: emailOrName,
      password: password, 
    );
    return userModel?.toEntity;
  }
  
  @override
  Future<List<UserEntity>> getUsers() async{
     List<UserModel> listUserMosel =  await userDataSource.getUsers( );
     return listUserMosel.map((e) => e.toEntity).toList();
  }
}
