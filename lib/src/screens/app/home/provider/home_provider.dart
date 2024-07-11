import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/repositories/product_repo.dart';
part 'home_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  int _offset = 10;
  final _repo = getIt<ProductRepo>();

  @override
  Future<ProductListData> build() async {
    return _loadProducts();
  }

  Future<void> loadMore() async {
    final products = await _repo.getProducts(_offset);
    final newProducts = products.map((json) => ProductModel.fromJson(json)).toList();
    _offset += newProducts.length;

    final previousState = await future;
    if (newProducts.isEmpty) {
      state = AsyncData(ProductListData(true, previousState.products));
    } else {
      state = AsyncData(ProductListData(false, [...previousState.products, ...newProducts]));
    }
  }

  Future<ProductListData> _loadProducts() async {
    _offset = 0;
    final products = await _repo.getProducts(_offset);
    _offset += products.length;
    return ProductListData(
      products.isEmpty,
      products.map((json) => ProductModel.fromJson(json)).toList(),
    );
  }
}

class ProductListData {
  final bool isFinished;
  final List<ProductModel> products;

  ProductListData(this.isFinished, this.products);
}
