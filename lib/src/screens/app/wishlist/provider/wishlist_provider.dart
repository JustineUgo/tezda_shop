import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/repositories/product_repo.dart';
import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
part 'wishlist_provider.g.dart';

@riverpod
class WishlistInfo extends _$WishlistInfo {
  final _repo = getIt<ProductRepo>();
  final _storage = getIt<StorageService>();
  @override
  Future<WishlistInfoData> build() async {
    final products = await _repo.getAllProducts();
    List wishlist = _storage.retrieveList(key: StorageService.wishlistKey) ?? [];

    return WishlistInfoData(
      products: products.map((json) => ProductModel.fromJson(json)).toList(),
      wishlist: wishlist.map((id) => int.parse(id)).toList(),
    );
  }

  Future<void> updateWishlist(int productId) async {
    List wishlist = _storage.retrieveList(key: StorageService.wishlistKey) ?? [];
    List<int> wishlist0 = wishlist.map((id) => int.parse(id)).toList();
    if (wishlist0.contains(productId)) {
      wishlist0.remove(productId);
    } else {
      wishlist0 = [...wishlist0, productId];
    }

    final previousState = await future;
    state = AsyncData(WishlistInfoData(products: previousState.products, wishlist: wishlist0));
    ref.read(homeInfoProvider.notifier).updateWishlist(wishlist0);
    _storage.storeList(key: StorageService.wishlistKey, value: wishlist0);
  }
}

class WishlistInfoData {
  final List<ProductModel> products;
  final List<int> wishlist;

  WishlistInfoData({required this.products, required this.wishlist});
}
