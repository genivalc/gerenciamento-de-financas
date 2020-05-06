import 'package:flutter/material.dart';
import 'package:gerenciar_financas_app/app/base_controller.dart';
import 'package:gerenciar_financas_app/app/pages/Home/home_view.dart';
import 'package:gerenciar_financas_app/app/pages/InitialUserInfo/initial_user_info_view.dart';
import 'package:gerenciar_financas_app/app/pages/Splash/splash_presenter.dart';
import 'package:gerenciar_financas_app/data/repositories/user_info.dart';

class SplashController extends BaseController {
  final SplashPresenter _splashPresenter;

  SplashController()
      : _splashPresenter = SplashPresenter(UserInfoRepository()),
        super();

  @override
  void initListeners() {
    _splashPresenter.onNext = (userInfo) {
      if (userInfo == null) {
        Navigator.of(getContext()).pushReplacement(
            MaterialPageRoute(builder: (context) => InitialUserInfoPage()));
      }
      else {
        Navigator.of(getContext()).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(userInfo)));
      }
    };

    _splashPresenter.onError = (e) {
      print(e);
      Navigator.of(getContext()).pushReplacement(
          MaterialPageRoute(builder: (context) => InitialUserInfoPage()));
    };
  }

  void loadInitialData() {
    _splashPresenter.loadData();
  }
}
