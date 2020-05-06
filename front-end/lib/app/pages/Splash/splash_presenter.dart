import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gerenciar_financas_app/domain/models/user_info.dart';
import 'package:gerenciar_financas_app/domain/usecases/get_saved_user_info.dart';

class SplashPresenter extends Presenter {
  Function onComplete;
  Function onError;
  Function onNext;

  final GetSavedUserInfoUseCase getSavedUserInfoUseCase;

  SplashPresenter(userInfoRepo)
      : getSavedUserInfoUseCase = GetSavedUserInfoUseCase(userInfoRepo);

  void loadData() {
    getSavedUserInfoUseCase.execute(_GetSavedUserInfoUseCaseObserver(this));
  }

  @override
  void dispose() {
    getSavedUserInfoUseCase.dispose();
  }
}

class _GetSavedUserInfoUseCaseObserver extends Observer<UserInfo> {
  final SplashPresenter presenter;

  _GetSavedUserInfoUseCaseObserver(this.presenter);

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
