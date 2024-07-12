import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/user/user_model.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
part 'profile_provider.g.dart';

@riverpod
class ProfileInfo extends _$ProfileInfo {
  final _storage = getIt<StorageService>();
  @override
  Future<UserModel> build() async {
    UserModel user = UserModel.fromJson(await _storage.retrieve(key: StorageService.userKey));
    return user;
  }
}

