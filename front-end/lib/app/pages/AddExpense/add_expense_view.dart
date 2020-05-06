import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/app/pages/AddExpense/add_expense_controller.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends View {
  final UserInfo userInfo;

  AddExpensePage(this.userInfo);

  @override
  State<StatefulWidget> createState() => _AddExpensePageState(userInfo);
}

class _AddExpensePageState
    extends ViewState<AddExpensePage, AddExpenseController> {
  _AddExpensePageState(userInfo) : super(AddExpenseController(userInfo));

  String dropdownValue = 'One';

  List<DropdownMenuItem<String>> categories = [
    DropdownMenuItem(
      child: Text('Mercado'),
      value: 'MERCADO',
    ),
    DropdownMenuItem(
      child: Text('PetShop'),
      value: 'PETSHOP',
    ),
    DropdownMenuItem(
      child: Text('Alimentação'),
      value: 'FOOD',
    ),
    DropdownMenuItem(
      child: Text('Transporte'),
      value: 'TRANSPORTATION',
    ),
    DropdownMenuItem(
      child: Text('Viagem'),
      value: 'TRAVEL',
    ),
  ];

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Adicionar Gasto'),
      ),
      body: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: controller.titleTextController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    prefixIcon: Icon(Icons.speaker_notes),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: controller.valueTextController,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    prefixIcon: Icon(Icons.monetization_on),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Flexible(
                flex: 1,
                child: DateTimeField(
                  keyboardType: TextInputType.datetime,
                  controller: controller.dateTimeTextController,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  format: DateFormat("\HH:mm"),
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: DropdownButton(
                  value: controller.category,
                  items: categories,
                  onChanged: (String value) {
                    setState(() {
                      controller.category = value;
                    });
                  },
                  hint: Text('Selecione uma categoria'),
                ),
              ),
              Spacer(flex: 1),
              Flexible(
                flex: 2,
                child: Row(
                  children: <Widget>[Expanded(child: saveButton('Salvar', 20))],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget saveButton(String text, double fontSize) {
    return FlatButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.indigo,
      highlightColor: Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
      onPressed: controller.saveExpense,
    );
  }
}
