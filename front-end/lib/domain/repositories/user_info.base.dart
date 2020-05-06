import 'package:gerenciar_financas_app/domain/models/user_info.dart';

abstract class UserInfoBaseRepository {
  Future saveUserInfo(UserInfo userInfo);
  Future<String> getSavedUserId();
  Future<UserInfo> getUserInfo(String userId);
}
