import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/app/base_controller.dart';
import 'package:gerenciar_financas_app/app/pages/Home/home_view.dart';
import 'package:gerenciar_financas_app/data/repositories/expense.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:intl/intl.dart';

import 'add_expense_presenter.dart';

class AddExpenseController extends BaseController {
  final UserInfo userInfo;
  bool _hasError = false;

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController valueTextController = TextEditingController();
  final TextEditingController dateTimeTextController = TextEditingController();
  String category;
  final AddExpensePresenter _addExpensePresenter;

  AddExpenseController(this.userInfo)
      : _addExpensePresenter = AddExpensePresenter(ExpenseRepository()),
        super();

  @override
  void initListeners() {
    _addExpensePresenter.onSaveComplete = () {
      if (!_hasError) Navigator.of(getContext()).pop();
    };

    _addExpensePresenter.onSaveError = (e) {
      showError(e);
      _hasError = true;
    };
  }

  void saveExpense() {
    DateTime time = DateFormat('HH:mm').parse(dateTimeTextController.text);
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//
//    print(date);
//    print(date.isUtc);
//    print(date.millisecondsSinceEpoch);
//    print(date.timeZoneOffset);
//    print(date.toLocal());

    _addExpensePresenter.saveExpense(
      titleTextController.text,
      double.parse(valueTextController.text),
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
      category,
      userInfo.email,
    );

    refreshUI();
  }
}
