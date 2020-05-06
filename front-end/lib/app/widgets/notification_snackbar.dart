import 'package:flutter/material.dart';

class NotificationSnackBar extends SnackBar {
  NotificationSnackBar(BuildContext context, String text)
      : super(
    content: _getContent(context, text),
    backgroundColor: Colors.white,
  );

  static Widget _getContent(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}