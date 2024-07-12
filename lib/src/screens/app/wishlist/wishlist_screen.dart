import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_error_section.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_widget.dart';
import 'package:tezda_shop/src/screens/app/wishlist/provider/wishlist_provider.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

@RoutePage()
class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(wishlistInfoProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wishlist', style: context.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text('Add and remove products from your favourites list', style: context.textTheme.bodyLarge),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: switch (productsState) {
                AsyncData(:WishlistInfoData value) => value.products.isEmpty
                    ? const Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('There are no products ')]),
                      )
                    : Column(
                        children: [
                          if (value.wishlist.isEmpty)
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(TezdaIcons.emptyIcon, height: 50),
                                    Text('You have not added any product your wishlist', style: context.textTheme.bodyLarge),
                                  ],
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Builder(builder: (context) {
                                //available bookmarked products
                                List<int> currentWishlist =
                                    value.wishlist.where((productId) => value.products.any((product) => product.id == productId)).toList();
                                return RefreshIndicator(
                                  onRefresh: () => ref.refresh(wishlistInfoProvider.future),
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    children: List.generate(currentWishlist.length, (index) {
                                      int wishlistProductdId = currentWishlist[index];
                                      final product = value.products.firstWhere((product) => product.id == wishlistProductdId);
                                      return ProductWidget(
                                        product: product,
                                        isFavourite: value.wishlist.contains(product.id),
                                        onFavourite: (id) => ref.read(wishlistInfoProvider.notifier).updateWishlist(id),
                                      );
                                    }),
                                  ),
                                );
                              }),
                            ),
                        ],
                      ),
                AsyncError() => ProductErrorSection(onPressed: () => ref.refresh(wishlistInfoProvider.future)),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
