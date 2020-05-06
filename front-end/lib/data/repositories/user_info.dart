import 'package:gerenciar_financas_app/data/storage/local.dart';
import 'package:gerenciar_financas_app/data/utils/http_helper.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class UserInfoRepository extends UserInfoBaseRepository {
  static const String _endpoint = 'api/user';

  @override
  Future saveUserInfo(UserInfo userInfo) async {
    await HttpHelper.invoke(
      _endpoint,
      RequestType.post,
      data: userInfo.toJson(),
    );
    LocalStorage.saveUserId(userInfo.email);
  }

  @override
  Future<UserInfo> getUserInfo(String userId) async {
    Map<String, dynamic> response =
        await HttpHelper.invoke('$_endpoint/$userId', RequestType.get);
    var userInfoJson = response['message']['Item'];
    return UserInfo.fromJson(userInfoJson);
  }

  @override
  Future<String> getSavedUserId() async {
    return await LocalStorage.getUserId();
//    return (await LocalStorage.getUserId()) ?? 'John.creed@terra.com.br';
  }
}
