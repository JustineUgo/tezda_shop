
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_widget.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    super.key,
    required this.scrollController,
    required this.value,
    required this.onRefresh,
  });

  final ScrollController scrollController;
  final HomeInfoData value;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: GridView.count(
        controller: scrollController,
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: List.generate(value.products.length, (index) {
          if (!value.isFinished && index == value.products.length - 1) return const Center(child: CircularProgressIndicator());
          ProductModel product = value.products[index];
          return ProductWidget(
            isFavourite: value.wishlist.contains(product.id),
            product: product,
          );
        }),
      ),
    );
  }
}
