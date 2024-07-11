import 'package:injectable/injectable.dart';
import 'package:tezda_shop/src/services/network_service.dart';
import 'package:tezda_shop/util/urls.dart';

abstract class ProductRepo {
  Future<List<dynamic>> getProducts(int offset);
}

@Singleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final NetworkService request;

  ProductRepoImpl({required this.request});
  @override
  Future<List<dynamic>> getProducts(int offset) async {
    return await request.makeRequest('${TezdaUrls.products}?offset=$offset&limit=10', mode: NetworkMethod.get);
  }
}
