import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/user/user_model.dart';
import 'package:tezda_shop/src/repositories/auth_repo.dart';
import 'package:tezda_shop/src/services/ui_service.dart';
part 'auth_provider.g.dart';

@riverpod
class AuthInfo extends _$AuthInfo {
  final _repo = getIt<AuthRepo>();
  final _ui = getIt<UIService>();

  @override
  Future<AuthInfoData> build() async {
    return AuthInfoData(isRegSuccessful: false, isLoginSuccessful: false);
  }

  Future<bool> register({required String email, required String name, required String password}) async {
    state = const AsyncLoading();
    UserModel user = UserModel.fromJson(await _repo.register(name: name, email: email, password: password));
    user;
    _ui.showToast(text: 'Registered successfully!', type: ToastType.success);
    state = AsyncData(AuthInfoData(isRegSuccessful: true, isLoginSuccessful: false));
    return true;
  }

  Future<bool> login({required String email, required String password}) async {
    state = const AsyncLoading();
    await _repo.login(email: email, password: password);
    _ui.showToast(text: 'Welcome!', type: ToastType.success);
    state = AsyncData(AuthInfoData(isRegSuccessful: false, isLoginSuccessful: true));
    return true;
  }
}

class AuthInfoData {
  final bool isRegSuccessful;
  final bool isLoginSuccessful;

  AuthInfoData({required this.isRegSuccessful, required this.isLoginSuccessful});
}
