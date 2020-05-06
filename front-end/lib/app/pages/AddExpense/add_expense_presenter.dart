import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/usecases/save_expense.dart';
import 'package:gerenciar_financas_app/domain/usecases/save_user_info.dart';

class AddExpensePresenter extends Presenter {
  Function onSaveComplete;
  Function onSaveError;

  final SaveExpenseUseCase saveExpenseUseCase;

  AddExpensePresenter(userInfoRepo)
      : saveExpenseUseCase = SaveExpenseUseCase(userInfoRepo);

  void saveExpense(
    String title,
    double value,
    DateTime dateTime,
    String category,
    String userId,
  ) {
    saveExpenseUseCase.execute(
      _SaveExpenseUseCaseObserver(this),
      SaveExpenseUseCaseParams(
        title,
        value,
        dateTime,
        category,
        userId,
      ),
    );
  }

  @override
  void dispose() {
    saveExpenseUseCase.dispose();
  }
}

class _SaveExpenseUseCaseObserver extends Observer<void> {
  final AddExpensePresenter presenter;

  _SaveExpenseUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    if (presenter.onSaveComplete == null) return;
    presenter.onSaveComplete();
  }

  @override
  void onError(e) {
    if (presenter.onSaveError == null) return;
    presenter.onSaveError(e);
  }

  @override
  void onNext(response) {}
}
