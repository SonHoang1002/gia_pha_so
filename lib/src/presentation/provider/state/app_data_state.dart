import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

abstract class AppDataState {
  final UserEntity? userEntity;
  AppDataState({required this.userEntity});
}

class InitAppDataState extends AppDataState {
  InitAppDataState() : super(userEntity: null);
}

class UpdateAppDataState extends AppDataState {
  @override
  final UserEntity userEntity;
  UpdateAppDataState({required this.userEntity}) : super(userEntity: userEntity);
}




