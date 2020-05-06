import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/expense.dart';
import 'package:gerenciar_financas_app/domain/usecases/fetch_user_expenses.dart';
import 'package:gerenciar_financas_app/domain/usecases/save_expense.dart';

class ExpensePresenter extends Presenter {
  Function onSaveComplete;
  Function onSaveError;
  Function onFetchComplete;
  Function onFetchError;
  Function onFetchNext;

  final SaveExpenseUseCase saveExpenseUseCase;
  final FetchUserExpensesUseCase fetchUserExpensesUseCase;

  ExpensePresenter(userInfoRepo)
      : saveExpenseUseCase = SaveExpenseUseCase(userInfoRepo),
        fetchUserExpensesUseCase = FetchUserExpensesUseCase(userInfoRepo);


  void fetchExpenses(String userId) {
    fetchUserExpensesUseCase.execute(
        _FetchUserExpenseUseCaseObserver(this), userId);
  }

  @override
  void dispose() {
    saveExpenseUseCase.dispose();
  }
}

class _SaveExpenseUseCaseObserver extends Observer<void> {
  final ExpensePresenter presenter;

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

class _FetchUserExpenseUseCaseObserver extends Observer<List<Expense>> {
  final ExpensePresenter presenter;

  _FetchUserExpenseUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    if (presenter.onFetchComplete == null) return;
    presenter.onFetchComplete();
  }

  @override
  void onError(e) {
    if (presenter.onFetchError == null) return;
    presenter.onFetchError(e);
  }

  @override
  void onNext(response) {
    if (presenter.onFetchNext == null) return;
    presenter.onFetchNext(response);
  }
}
