import 'package:mobx/mobx.dart';
part 'loading.g.dart';

class LoadingUtil = _LoadingUtilBase with _$LoadingUtil;

abstract class _LoadingUtilBase with Store {
  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }
}
