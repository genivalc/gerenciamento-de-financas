import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:gerenciar_financas_app/app/base_controller.dart';
import 'package:gerenciar_financas_app/app/pages/Home/home_view.dart';
import 'package:gerenciar_financas_app/app/pages/InitialUserInfo/initial_user_info_presenter.dart';
import 'package:gerenciar_financas_app/data/repositories/user_info.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';

class InitialUserInfoController extends BaseController {
  int radioValue = -1;
  CarouselController carouselController = CarouselController();
  int currentStep = 0;

  bool autoValidatePersonalDataForm = false;
  bool autoValidateIncomeForm = false;
  bool autoValidateExpensesForm = false;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController incomeTextController = TextEditingController();
  final TextEditingController expensesTextController = TextEditingController();

  final SaveUserInfoPresenter _saveUserInfoPresenter;

  bool _hasError = false;

  InitialUserInfoController()
      : _saveUserInfoPresenter = SaveUserInfoPresenter(UserInfoRepository()),
        super();

  @override
  void initListeners() {
    _saveUserInfoPresenter.onNext = (userInfo) {
      if (!_hasError)
        Navigator.of(getContext()).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(userInfo)));
    };

    _saveUserInfoPresenter.onError = (e) {
      showError(e);
      _hasError = true;
    };
  }

  void handleRadioChange(int value) {
    radioValue = value;
    refreshUI();
  }

  void onStepChanged(index, reason) {
    currentStep = index;
    refreshUI();
  }

  bool personalDataFormIsNotValid() {
    if (validateNameField(nameTextController.text) != null) return true;
    if (validateEmailField(emailTextController.text) != null) return true;
    if (validatePhoneField(phoneTextController.text) != null) return true;
    return false;
  }

  bool incomeFormIsNotValid() {
    if (validateIncomeField(incomeTextController.text) != null) return true;
    return false;
  }

  bool expensesFormIsNotValid() {
    if (validateExpensesField(expensesTextController.text) != null) return true;
    return false;
  }

  String validateNameField(String value) {
    if (value.isEmpty) {
      return "Esse campo é obrigatório";
    }
    return null;
  }

  String validateEmailField(String value) {
    if (value.isEmpty) {
      return "Esse campo é obrigatório";
    }
    // TODO: verificar se o e-mail é válido
    return null;
  }

  String validatePhoneField(String value) {
    if (value.isEmpty) {
      return "Esse campo é obrigatório";
    }
    // TODO: verificar se o número de telefone é válido
    return null;
  }

  String validateIncomeField(String value) {
    if (value.isEmpty) {
      return "Esse campo é obrigatório";
    }
    if (double.tryParse(value.replaceFirst(",", ".")) == null) {
      return "Esse campo deve ser um número decimal";
    }
    return null;
  }

  String validateExpensesField(String value) {
    if (value.isEmpty) {
      return "Esse campo é obrigatório";
    }
    if (double.tryParse(value.replaceFirst(",", ".")) == null) {
      return "Esse campo deve ser um número decimal";
    }
    return null;
  }

  void previousStep() {
    carouselController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void nextStep() {
    bool changeStep = true;

    switch (currentStep) {
      case 1:
        autoValidatePersonalDataForm = true;
        if (personalDataFormIsNotValid()) changeStep = false;
        break;
      case 2:
        autoValidateIncomeForm = true;
        if (incomeFormIsNotValid()) changeStep = false;
        break;
      case 3:
        autoValidateExpensesForm = true;
        if (expensesFormIsNotValid()) changeStep = false;
        break;
      case 4:
        saveUserInfo();
        return;
    }

    if (changeStep) {
      carouselController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }

    refreshUI();
  }

  void saveUserInfo() {
    if (personalDataFormIsNotValid() ||
        incomeFormIsNotValid() ||
        expensesFormIsNotValid()) return;

    _saveUserInfoPresenter.save(
      nameTextController.text,
      emailTextController.text,
      phoneTextController.text,
      radioValue == 1 || radioValue == 2,
      radioValue == 1 || radioValue == 3,
      double.parse(incomeTextController.text),
      double.parse(expensesTextController.text),
    );
  }
}
