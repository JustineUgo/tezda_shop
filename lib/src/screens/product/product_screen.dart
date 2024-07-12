import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/screens/product/widgets/brand_tile.dart';
import 'package:tezda_shop/src/screens/product/widgets/review_tile.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/extensions.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});
  final ProductModel product;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () => context.router.removeLast(),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TezdaColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(CupertinoIcons.chevron_back, color: TezdaColors.dark),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width - 40,
                        width: MediaQuery.of(context).size.width,
                        child: TezdaImage(image: widget.product.images.first.imageUrl()),
                      ),
                      const SizedBox(height: 20),
                      Text(widget.product.title, style: context.textTheme.titleLarge),
                      Text('5.0 (3 Reviews)', style: context.textTheme.bodyMedium),
                      const SizedBox(height: 5),
                      Text('\$${widget.product.price}', style: context.textTheme.titleMedium),
                      const SizedBox(height: 20),
                      Text('Description', style: context.textTheme.headlineLarge),
                      const SizedBox(height: 10),
                      Text(widget.product.description),
                      const SizedBox(height: 20),
                      Text('Review (3)', style: context.textTheme.headlineLarge),
                      const SizedBox(height: 10),
                      ReviewTile(image: widget.product.category.image),
                      ReviewTile(image: widget.product.category.image),
                      ReviewTile(image: widget.product.category.image),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            BrandTile(image: widget.product.category.image),
          ],
        ),
      ),
    );
  }
}
