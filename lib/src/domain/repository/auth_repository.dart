
import 'package:gia_pha_so/src/data/model/user_model.dart';

abstract class AuthRepository {
  // type UserRegisterDataModel struct {
  // 	Username string `json:"username"`
  // 	Phone    string `json:"phone"`
  // 	Email    string `json:"email"`
  // 	Password string `json:"password"`
  // }

  /// "data": map[string]interface{}{
  /// 	"id":        insertedId,
  /// 	"uid":       newUserCreateModel.UId,
  /// 	"username":  newUserCreateModel.Username,
  /// 	"email":     newUserCreateModel.Email,
  /// 	"createdAt": time.Now(),
  /// },
  Future<dynamic> register(UserRegisterDataModel data);
  // type UserLoginDataModel struct {
  // 	PhoneOrEmail string `json:"phoneOrEmail"`
  // 	Password     string `json:"password"`
  // }
  ///   {
  ///     "data": {
  ///         "user": {
  ///             "Id": "6996e479339862e206be9375",
  ///             "uid": "OBREC0794106",
  ///             "username": "hello4323223",
  ///             "hashed_password": "$2a$10$WZtWyHAligadOvTm3EP5Z.YrgGCZoR3PD1iXY.ozidKoYFQFsehHC",
  ///             "password": "Asd123423.",
  ///             "email": "abc1271@gmail.com",
  ///             "role": "",
  ///             "real_name": "",
  ///             "gender": "",
  ///             "birthday": "",
  ///             "deathday": "",
  ///             "birth_place": "",
  ///             "death_place": "",
  ///             "biography": "",
  ///             "avatar": "",
  ///             "phone": "2023482322",
  ///             "address": "",
  ///             "spouse": [],
  ///             "siblings": [],
  ///             "parents": [],
  ///             "children": [],
  ///             "nationality": "",
  ///             "ethnicity": "",
  ///             "religion": "",
  ///             "profession": "",
  ///             "education": "",
  ///             "isPublic": true,
  ///             "viewers": [],
  ///             "editors": null,
  ///             "createdBy": "",
  ///             "updatedBy": "",
  ///             "createdAt": "2026-02-19T10:22:49.565Z",
  ///             "updatedAt": "2026-02-19T10:22:49.565Z",
  ///             "deletedAt": null,
  ///             "notes": "",
  ///             "tags": []
  ///         }
  ///     },
  ///     "error": null,
  ///     "success": true
  /// }
  Future<dynamic> login(UserLoginDataModel data);
}
