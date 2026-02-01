import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

abstract class AppDataEvent {
  AppDataEvent();
}

class UpdateAppDataEvent extends AppDataEvent {
  final UserEntity userEntity;
  UpdateAppDataEvent({required this.userEntity});
}
