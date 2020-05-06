import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/app/pages/Splash/splash_controller.dart';

class SplashPage extends View {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends ViewState<SplashPage, SplashController> {
  SplashPageState() : super(SplashController());

  @override
  void initState() {
    super.initState();
    Future.delayed(
        new Duration(milliseconds: 1000), controller.loadInitialData);
  }

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 5,
                ),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: Center(
                  child: Icon(
                    Icons.attach_money,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
