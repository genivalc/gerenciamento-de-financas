import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class SaveUserInfoUseCase
    extends UseCase<UserInfo, SaveUserInfoUseCaseParams> {
  final UserInfoBaseRepository userInfoRepository;

  SaveUserInfoUseCase(this.userInfoRepository);

  @override
  Future<Stream<UserInfo>> buildUseCaseStream(
      SaveUserInfoUseCaseParams params) async {
    final StreamController<UserInfo> controller = StreamController();
    try {
      UserInfo userInfo = new UserInfo(
        name: params.name,
        email: params.email,
        phone: params.phone,
        flagTipsEmail: params.flagTipsEmail,
        flagTipsPhone: params.flagTipsPhone,
        monthlyIncome: params.monthlyIncome,
        monthlyExpenses: params.monthlyExpenses,
      );
      await userInfoRepository.saveUserInfo(userInfo);

      controller.add(userInfo);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}

class SaveUserInfoUseCaseParams {
  final String name;
  final String email;
  final String phone;
  final bool flagTipsEmail;
  final bool flagTipsPhone;
  final double monthlyIncome;
  final double monthlyExpenses;

  SaveUserInfoUseCaseParams(
    this.name,
    this.email,
    this.phone,
    this.flagTipsEmail,
    this.flagTipsPhone,
    this.monthlyIncome,
    this.monthlyExpenses,
  );
}
