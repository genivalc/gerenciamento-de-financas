import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class GetSavedUserInfoUseCase extends UseCase<UserInfo, void> {
  final UserInfoBaseRepository userInfoRepository;

  GetSavedUserInfoUseCase(this.userInfoRepository);

  @override
  Future<Stream<UserInfo>> buildUseCaseStream(void params) async {
    final StreamController<UserInfo> controller = StreamController();
    try {
      String userId = await userInfoRepository.getSavedUserId();

      print(userId);

      UserInfo userInfo;
      if (userId != null) {
        userInfo = await userInfoRepository.getUserInfo(userId);
      }

      print(userInfo);

      controller.add(userInfo);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
