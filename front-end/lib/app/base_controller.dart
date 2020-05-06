import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/app/widgets/notification_snackbar.dart';
import 'package:gerenciar_financas_app/data/exceptions/api_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/request_canceled_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/server_access_exception.dart';
import 'package:gerenciar_financas_app/data/exceptions/server_timeout_exception.dart';

abstract class BaseController extends Controller {
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  @protected
  void setBusy(bool busy, {bool refresh = true}) {
    _isBusy = busy;
    if (refresh) refreshUI();
  }

  BaseController() : super();

  @protected
  void showError(e) {
    ScaffoldState state = getState();

    var message =
        'Erro inesperado: ${e?.message ?? "Desconhecido"}';

    if (e != null) {
      if (e is RequestCanceledException) {
        message = "A requisição foi cancelada";
      } else if (e is ServerAccessException) {
        message = "Não foi possível acessar o servidor";
      } else if (e is ServerTimeoutException) {
        message = "O servidor não respondeu a tempo";
      } else if (e is APIException) {
        APIException apiEx = e;
        message = apiEx.message != null && apiEx.message.isNotEmpty
            ? apiEx.message
            : 'Erro inesperado: ${apiEx.statusText ?? apiEx.statusCode}';
      }
    }

    state.showSnackBar(NotificationSnackBar(state.context, message));
    refreshUI();
  }
}
