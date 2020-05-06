import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/expense.base.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class FetchUserExpensesUseCase extends UseCase<List<Expense>, String> {
  final ExpenseBaseRepository expenseBaseRepository;

  FetchUserExpensesUseCase(this.expenseBaseRepository);

  @override
  Future<Stream<List<Expense>>> buildUseCaseStream(String params) async {
    final StreamController<List<Expense>> controller = StreamController();
    try {
      var date = DateTime.now().millisecondsSinceEpoch;
      List<Expense> expenses = await expenseBaseRepository.fetchExpenses(params, date);
      controller.add(expenses);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
