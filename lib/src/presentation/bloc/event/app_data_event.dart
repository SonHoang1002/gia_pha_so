import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

abstract class AppDataEvent {
  AppDataEvent();
}

class UpdateAppDataEvent extends AppDataEvent {
  final String token;
  final String refreshToken;
  final UserEntity userEntity;
  UpdateAppDataEvent({
    required this.token,
    required this.refreshToken,
    required this.userEntity,
  });
}
