import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/expense.base.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class SaveExpenseUseCase extends CompletableUseCase<SaveExpenseUseCaseParams> {
  final ExpenseBaseRepository expenseBaseRepository;

  SaveExpenseUseCase(this.expenseBaseRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      SaveExpenseUseCaseParams params) async {
    final StreamController<void> controller = StreamController();
    try {
      Expense expense = Expense(
        title: params.title,
        value: params.value,
        dateTime: params.dateTime,
        category: params.category
      );

      await expenseBaseRepository.saveExpense(expense, params.email);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}

class SaveExpenseUseCaseParams {
  final String title;
  final double value;
  final DateTime dateTime;
  final String category;
  final String email;

  SaveExpenseUseCaseParams(this.title, this.value, this.dateTime, this.category, this.email);
}
