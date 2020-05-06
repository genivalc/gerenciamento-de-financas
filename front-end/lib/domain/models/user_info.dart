import 'package:gerenciar_financas_app/domain/models/expense.dart';

class UserInfo {
  String name;
  String email;
  String phone;
  bool flagTipsEmail;
  bool flagTipsPhone;
  double monthlyIncome;
  double monthlyExpenses;
  List<Expense> additionalExpenses;

  UserInfo({
    this.name,
    this.email,
    this.phone,
    this.flagTipsEmail,
    this.flagTipsPhone,
    this.monthlyIncome,
    this.monthlyExpenses,
    this.additionalExpenses,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    var expenses = List<Expense>();
    if (json.containsKey('gastos')) {
      var expensesJson = json['gastos'] as List<dynamic>;
      expenses = expensesJson.map((v) => Expense.fromJson(v)).toList();
    }

    return UserInfo(
      name: json['nomeUsuario'],
      email: json['email_id'],
      phone: json['celular'],
      flagTipsEmail: json['flagDicasEmail'],
      flagTipsPhone: json['flagDicasCelular'],
      monthlyIncome: json['rendaMes']?.toDouble() ?? 0,
      monthlyExpenses: json['gastosMes']?.toDouble() ?? 0,
      additionalExpenses: expenses,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeUsuario'] = this.name;
    data['email_id'] = this.email;
    data['celular'] = this.phone;
    data['flagDicasEmail'] = this.flagTipsEmail;
    data['flagDicasCelular'] = this.flagTipsPhone;
    data['rendaMes'] = this.monthlyIncome;
    data['gastosMes'] = this.monthlyExpenses;
    if (additionalExpenses?.length ?? 0 > 0 ) {
      data['gastos'] = additionalExpenses.map((v) => v.toJson());
    }
    return data;
  }
}
