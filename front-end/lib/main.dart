import 'package:flutter/material.dart';
import 'package:gerenciar_financas_app/app/pages/Home/home_view.dart';
import 'package:gerenciar_financas_app/app/pages/Splash/splash_view.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildMain();
  }
}

class BuildMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADMI',
      theme:
          ThemeData().copyWith(appBarTheme: AppBarTheme(color: Colors.black)),
//      home: HomePage(UserInfo()),
      home: SplashPage(),
    );
  }
}
