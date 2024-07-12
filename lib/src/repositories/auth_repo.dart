import 'package:injectable/injectable.dart';
import 'package:tezda_shop/src/services/network_service.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
import 'package:tezda_shop/util/urls.dart';

abstract class AuthRepo {
  bool get isAuthenticated;
  Future<dynamic> register({required String name, required String email, required String password});
  Future<dynamic> login({required String email, required String password});
  Future getUser();
}

@Singleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final StorageService storage;
  final NetworkService request;

  AuthRepoImpl(this.request, {required this.storage});

  @override
  bool get isAuthenticated => storage.retrieve(key: StorageService.userAccessTokenKey) != null;

  @override
  Future register({required String name, required String email, required String password}) async {
    final result = await request.makeRequest(
      TezdaUrls.users,
      mode: NetworkMethod.post,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "avatar": "https://img.freepik.com/premium-photo/graphic-designer-digital-avatar-generative-ai_934475-9292.jpg,"
      },
    );
    storage.store(key: StorageService.userKey, value: result);
    return result;
  }

  @override
  Future login({required String email, required String password}) async {
    final response = await request.makeRequest(
      TezdaUrls.login,
      mode: NetworkMethod.post,
      body: {
        "password": password,
        "email": email,
      },
    );

    if (response["access_token"] != null) {
      storage.store(key: StorageService.userAccessTokenKey, value: response["access_token"]);
      await getUser();
    }
    if (response["refresh_token"] != null) {
      storage.store(key: StorageService.userAccessTokenKey, value: response["refresh_token"]);
    }
  }

  @override
  Future getUser() async {
    final response = await request.makeRequest(TezdaUrls.profile, mode: NetworkMethod.get);
    response;
    storage.store(key: StorageService.userKey, value: response);
  }
}
