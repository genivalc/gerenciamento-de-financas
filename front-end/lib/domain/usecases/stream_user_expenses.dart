import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/repositories/expense.base.dart';
import 'package:gerenciar_financas_app/domain/repositories/user_info.base.dart';

class StreamUserExpensesUseCase extends UseCase<List<Expense>, String> {
  final ExpenseBaseRepository expenseBaseRepository;

  StreamUserExpensesUseCase(this.expenseBaseRepository);

  StreamController<List<Expense>> _controller;

  @override
  Future<Stream<List<Expense>>> buildUseCaseStream(String userId) async {
    _controller = StreamController();
    Timer.periodic(Duration(seconds: 30), (Timer t) async {
      try {
        var date = DateTime.now().millisecondsSinceEpoch;
        print(date);
        List<Expense> expenses =
            await expenseBaseRepository.fetchExpenses(userId, date);
        _controller.add(expenses);
      } catch (e) {
        _controller.addError(e);
      }
    });
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
