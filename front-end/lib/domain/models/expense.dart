class Expense {
  String title;
  double value;
  DateTime dateTime;
  String category;
  String company;
  int parcel;

  int get unixDateTime => dateTime?.toUtc()?.millisecondsSinceEpoch ?? 0;

  Expense({this.title, this.value, this.dateTime, this.category, this.company, this.parcel,});

  factory Expense.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Expense(
      title: json['descricaoGasto'],
      value: json['valorGasto']?.toDouble() ?? 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        json['dataDespesa'],
        isUtc: true,
      ),
      category: json['categoria'],
      company: json['empresa'],
      parcel: json['parcelas'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricaoGasto'] = this.title;
    data['valorGasto'] = this.value;
    data['dataDespesa'] = this.unixDateTime;
    data['categoria'] = this.category;
    data['empresa'] = this.company;
    data['parcelas'] = this.parcel;
    return data;
  }
}
