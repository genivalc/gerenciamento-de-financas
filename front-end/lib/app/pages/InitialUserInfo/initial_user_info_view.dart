import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'initial_user_info_controller.dart';

void run() => runApp(InitialUserInfoPage());

class InitialUserInfoPage extends View {
  @override
  State<StatefulWidget> createState() => InitialUserInfoPageState();
}

class InitialUserInfoPageState
    extends ViewState<InitialUserInfoPage, InitialUserInfoController> {
  InitialUserInfoPageState() : super(InitialUserInfoController());

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      body: Container(
        color: Colors.cyan,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height - 100,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    onPageChanged: controller.onStepChanged),
                carouselController: controller.carouselController,
                items: <Widget>[
                  welcomeStep(),
                  personalDataStep(),
                  incomeStep(),
                  expenseStep(),
                  tipStep()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                indicatorDot(controller.currentStep == 0),
                indicatorDot(controller.currentStep == 1),
                indicatorDot(controller.currentStep == 2),
                indicatorDot(controller.currentStep == 3),
                indicatorDot(controller.currentStep == 4)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget indicatorDot(bool selected) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? Color.fromRGBO(0, 0, 0, 0.9)
              : Color.fromRGBO(0, 0, 0, 0.4)),
    );
  }

  Widget welcomeStep() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(flex: 1),
            reusableTextHeader('Seja bem vindo!'),
            SizedBox(height: 30),
            reusableTextWithTextStyle(
                'Olá, estamos felizes com o seu primeiro passo para uma vida financeira mais saudável.',
                20),
            SizedBox(height: 10),
            reusableTextWithTextStyle(
                'Primeiramente, precisamos saber alguns dados seus. Mas, não se preocupe, você poderá alterá-los quando desejar.',
                20),
            Spacer(flex: 1),
            Row(children: <Widget>[
              Expanded(child: doneButton("Vamos lá!", 20))
            ])
          ],
        ),
      ),
    );
  }

  Widget personalDataStep() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(flex: 1),
            reusableTextHeader('Dados pessoais'),
            SizedBox(height: 10),
            reusableTextFieldWithTextStyle(
              'Nome',
              20,
              textController: controller.nameTextController,
              validator: controller.validateNameField,
            ),
            SizedBox(height: 10),
            reusableTextFieldWithTextStyle(
              'E-mail',
              20,
              inputType: TextInputType.emailAddress,
              textController: controller.emailTextController,
              validator: controller.validateEmailField,
            ),
            SizedBox(height: 10),
            reusableTextFieldWithTextStyle(
              'Celular',
              20,
              inputType: TextInputType.phone,
              textController: controller.phoneTextController,
              validator: controller.validatePhoneField,
            ),
            Spacer(flex: 1),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded (child: previousButton("Voltar", 15)),
                Spacer(),
                Expanded (child: doneButton("Prosseguir", 15))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeStep() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(flex: 1),
          reusableTextHeader('Receita'),
          SizedBox(height: 30),
          reusableTextWithTextStyle(
              'Em média, quanto você recebe mensalmente?', 20),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.monetization_on),
            ),
            keyboardType: TextInputType.number,
            controller: controller.incomeTextController,
            autovalidate: controller.autoValidateIncomeForm,
            validator: controller.validateIncomeField,
          ),
          Spacer(flex: 1),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: previousButton("Voltar", 15)),
              Spacer(),
              Expanded(child: doneButton("Prosseguir", 15))
            ],
          ),
        ],
      ),
    );
  }

  Widget expenseStep() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(flex: 1),
          reusableTextHeader('Despesas'),
          SizedBox(height: 30),
          reusableTextWithTextStyle(
              'Aproximadamente, quais são as suas despesas fixas mensais (água, luz, gás, internet, etc)?',
              20),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.monetization_on),
            ),
            keyboardType: TextInputType.number,
            controller: controller.expensesTextController,
            autovalidate: controller.autoValidateExpensesForm,
            validator: controller.validateExpensesField,
          ),
          Spacer(flex: 1),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: previousButton("Voltar", 15)),
              Spacer(),
              Expanded(child: doneButton("Prosseguir", 15))
            ],
          ),
        ],
      ),
    );
  }

  Widget tipStep() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(flex: 1),
          reusableTextHeader('Dicas'),
          SizedBox(height: 30),
          Text(
            'Para finalizar, você gostaria de receber informações e dicas sobre como cuidar melhor da sua saúde financeira?',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 10),
          RadioListTile(
            value: 1,
            onChanged: controller.handleRadioChange,
            groupValue: controller.radioValue,
            title: Text('Sim, por e-mail e por SMS',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          RadioListTile(
            value: 2,
            onChanged: controller.handleRadioChange,
            groupValue: controller.radioValue,
            title: Text('Sim, somente por e-mail',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          RadioListTile(
            value: 3,
            onChanged: controller.handleRadioChange,
            groupValue: controller.radioValue,
            title: Text('Sim, somente por SMS',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          RadioListTile(
            value: 3,
            onChanged: controller.handleRadioChange,
            groupValue: controller.radioValue,
            title: Text('Não', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: previousButton("Voltar", 15)),
              Spacer(),
              Expanded(child: doneButton("Concluir", 15))
            ],
          ),
        ],
      ),
    );
  }

  Widget doneButton(String text, double fontSize) {
    return FlatButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.indigo,
      highlightColor: Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
      onPressed: controller.nextStep,
    );
  }

  Widget previousButton(String text, double fontSize) {
    return OutlineButton(
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.indigo,
      highlightedBorderColor: Colors.white,
      highlightColor: Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      borderSide: BorderSide(color: Colors.white),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
      onPressed: controller.previousStep,
    );
  }

  Widget reusableTextHeader(String value) {
    return Text(value,
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black));
  }

  Widget reusableTextWithTextStyle(String value, double fontSize) {
    return Text(value,
        style: TextStyle(fontSize: fontSize, color: Colors.white));
  }

  Widget reusableTextFieldWithTextStyle(
    String labelText,
    double fontSize, {
    TextInputType inputType = TextInputType.text,
    TextEditingController textController,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: textController,
      keyboardType: inputType,
      autovalidate: controller.autoValidatePersonalDataForm,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        fillColor: Colors.white,
      ),
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        decorationColor: Colors.white,
      ),
    );
  }
}
