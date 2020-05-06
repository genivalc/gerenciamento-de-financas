import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/app/pages/Home/home_controller.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const icons = {
  'MERCADO': FontAwesomeIcons.shoppingBasket,
  'PETSHOP': FontAwesomeIcons.paw,
  'FOOD': FontAwesomeIcons.hamburger,
  'TRANSPORTATION': FontAwesomeIcons.taxi,
  'TRAVEL': FontAwesomeIcons.suitcaseRolling,
};

class HomePage extends View {
  final UserInfo userInfo;

  HomePage(this.userInfo);

  @override
  State<StatefulWidget> createState() => _HomePageState(userInfo);
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState(userInfo) : super(HomeController(userInfo));

  @override
  void initState() {
    super.initState();
  }

  Widget doneButton(String text, double fontSize) {
    return FlatButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.indigo,
      highlightColor: Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
      onPressed: () {},
    );
  }

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: getBackgroundGradientColors(
                controller.remainingDailyLimitPercent),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            header(),
            Flexible(
              flex: 2,
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                elevation: 0,
                margin: EdgeInsets.only(
                  bottom: 0,
                  left: 8,
                  right: 8,
                  top: 4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Gastos de hoje',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            controller.navigateToAddExpense();
                          }),
                    ),
                    Expanded(
                      child: (controller.expensesOfTheDay?.length ?? 0) <= 0
                          ? emptyListView()
                          : ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  controller.expensesOfTheDay?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                var expense =
                                    controller.expensesOfTheDay[index];
                                return ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        icons[expense.category],
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    expense.title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    DateFormat()
                                        .add_Hm()
                                        .format(expense.dateTime),
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        expense.value.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    var remainingDailyLimitTxt =
        controller.remainingDailyLimit.isNegative ? '-' : '';
    remainingDailyLimitTxt +=
        'R\$${(controller.remainingDailyLimit.abs() ?? 0).toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            getSentimentIcon(controller.remainingDailyLimitPercent),
            color: Colors.white,
            size: 70,
          ),
          Text(
            remainingDailyLimitTxt,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.orange),
            ),
            child: LinearProgressIndicator(
              value: controller.remainingDailyLimitPercent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  IconData getSentimentIcon(double remainingLimitPercent) {
    if (remainingLimitPercent > 0.75) {
      return Icons.sentiment_very_satisfied;
    } else if (remainingLimitPercent > 0.5) {
      return Icons.sentiment_satisfied;
    } else if (remainingLimitPercent > 0.25) {
      return Icons.sentiment_neutral;
    } else if (remainingLimitPercent >= 0) {
      return Icons.sentiment_dissatisfied;
    }

    return Icons.sentiment_very_dissatisfied;
  }

  List<Color> getBackgroundGradientColors(double remainingLimitPercent) {
    if (remainingLimitPercent > 0.75) {
      return [
        Colors.green,
        Colors.greenAccent,
      ];
    } else if (remainingLimitPercent > 0.5) {
      return [
        Colors.lightGreen,
        Colors.lightGreenAccent,
      ];
    } else if (remainingLimitPercent > 0.25) {
      return [
        Colors.yellow,
        Colors.yellowAccent,
      ];
    } else if (remainingLimitPercent >= 0) {
      return [
        Colors.amber,
        Colors.amberAccent,
      ];
    }

    return [
      Colors.red,
      Colors.redAccent,
    ];
  }

  Widget emptyListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.monetization_on,
          color: Colors.white,
          size: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
          ),
          child: Text(
            'Parabéns, você não possui gastos hoje',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
