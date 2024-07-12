import 'package:injectable/injectable.dart';
import 'package:tezda_shop/src/services/network_service.dart';
import 'package:tezda_shop/util/urls.dart';

abstract class ProductRepo {
  Future<List<dynamic>> getProducts(int offset, {int? categoryFilterId});
  Future<List<dynamic>> getCategories();
}

@Singleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final NetworkService request;

  ProductRepoImpl({required this.request});
  @override
  Future<List<dynamic>> getProducts(int offset, {int? categoryFilterId}) async {
    return await request.makeRequest('${TezdaUrls.products}?${categoryFilterId!=null?'categoryId=$categoryFilterId&':''}offset=$offset&limit=10', mode: NetworkMethod.get);
  }
  @override
  Future<List<dynamic>> getCategories() async {
    return await request.makeRequest(TezdaUrls.categories, mode: NetworkMethod.get);
  }
}
