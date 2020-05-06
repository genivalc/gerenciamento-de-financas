import 'package:gerenciar_financas_app/domain/models/expense.dart';

abstract class ExpenseBaseRepository {
  Future saveExpense(Expense expense, String userId);
  Future fetchExpenses(String email, int date);
}
