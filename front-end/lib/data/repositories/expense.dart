import 'package:gerenciar_financas_app/data/utils/http_helper.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/repositories/expense.base.dart';

class ExpenseRepository extends ExpenseBaseRepository {
  static const String _endpoint = 'api/user/expenses';
  static const String _endpointGet = 'api/user';

  @override
  Future saveExpense(Expense expense, String userId) async {
    var data = {
      "email_id": userId,
      "gasto": expense.toJson(),
    };
    await HttpHelper.invoke(
      _endpoint,
      RequestType.post,
      data: data,
    );
  }

  @override
  Future<List<Expense>> fetchExpenses(String userId, int date) async {
    Map<String, dynamic> response = await HttpHelper.invoke(
        '$_endpointGet/$userId/date/$date', RequestType.get);

    List<dynamic> expensesJson = response['message'];
    if (expensesJson == null) return null;
    return expensesJson.map((v) => Expense.fromJson(v)).toList();
  }
}
