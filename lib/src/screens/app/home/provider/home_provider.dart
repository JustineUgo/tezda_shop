import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/repositories/product_repo.dart';
part 'home_provider.g.dart';

@riverpod
class HomeInfo extends _$HomeInfo {
  final _repo = getIt<ProductRepo>();
  int _offset = 10;
  int? _categoryFilterId;
  List<int> _wishlist = [];

  @override
  Future<HomeInfoData> build() async {
    _offset = 0;
    _categoryFilterId = null;
    _wishlist = [253, 255, 256, 265];
    state = const AsyncLoading();
    return _loadProducts();
  }

  Future<void> loadMore() async {
    final products = await _repo.getProducts(_offset, categoryFilterId: _categoryFilterId);
    final newProducts = products.map((json) => ProductModel.fromJson(json)).toList();
    _offset += newProducts.length;

    final previousState = await future;
    if (newProducts.isEmpty || newProducts.length < 10) {
      state = AsyncData(
        HomeInfoData(
          isFinished: true,
          wishlist: _wishlist,
          products: previousState.products,
          categories: previousState.categories,
        categoryFilter: _categoryFilterId,
        ),
      );
    } else {
      state = AsyncData(
        HomeInfoData(
          isFinished: false,
          wishlist: _wishlist,
          products: [...previousState.products, ...newProducts],
          categories: previousState.categories,
        categoryFilter: _categoryFilterId,
        ),
      );
    }
  }

  Future<HomeInfoData> _loadProducts() async {
    final products = await _repo.getProducts(_offset, categoryFilterId: _categoryFilterId);
    final categories = await _repo.getCategories();
    _offset += products.length;
    return HomeInfoData(
      isFinished: products.isEmpty || products.length < 10,
      wishlist: _wishlist,
      categories: categories.map((json) => Category.fromJson(json)).toList(),
      products: products.map((json) => ProductModel.fromJson(json)).toList(),
        categoryFilter: _categoryFilterId,
    );
  }

  Future filterProductsByCategory(int categoryId) async {
    _offset = 0;
    _categoryFilterId = categoryId;

    final previousState = await future;
    state = const AsyncLoading();

    final products = await _repo.getProducts(_offset, categoryFilterId: _categoryFilterId);
    _offset += products.length;
    state = AsyncData(
      HomeInfoData(
        isFinished: products.isEmpty || products.length < 10,
        wishlist: _wishlist,
        categories: previousState.categories,
        products: products.map((json) => ProductModel.fromJson(json)).toList(),
        categoryFilter: _categoryFilterId,
      ),
    );
  }
}

class HomeInfoData {
  final bool isFinished;
  final List<ProductModel> products;
  final List<Category> categories;
  final List<int> wishlist;
  final int? categoryFilter;

  HomeInfoData({required this.isFinished, required this.categories, required this.products, required this.wishlist, this.categoryFilter});
}
