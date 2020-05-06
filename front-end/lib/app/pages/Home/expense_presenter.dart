import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/usecases/fetch_user_expenses.dart';
import 'package:gerenciar_financas_app/domain/usecases/save_expense.dart';
import 'package:gerenciar_financas_app/domain/usecases/stream_user_expenses.dart';

class StreamExpensePresenter extends Presenter {
  Function onComplete;
  Function onError;
  Function onNext;

  final StreamUserExpensesUseCase streamUserExpensesUseCase;

  StreamExpensePresenter(userInfoRepo)
      : streamUserExpensesUseCase = StreamUserExpensesUseCase(userInfoRepo);

  void begin(String userId) {
    streamUserExpensesUseCase.execute(
        _StreamUserExpensesUseCaseObserver(this), userId);
  }

  @override
  void dispose() {
    streamUserExpensesUseCase.dispose();
  }
}

class _StreamUserExpensesUseCaseObserver extends Observer<List<Expense>> {
  final StreamExpensePresenter presenter;

  _StreamUserExpensesUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    if (presenter.onComplete == null) return;
    presenter.onComplete();
  }

  @override
  void onError(e) {
    if (presenter.onError == null) return;
    presenter.onError(e);
  }

  @override
  void onNext(response) {
    if (presenter.onNext == null) return;
    presenter.onNext(response);
  }
}
