import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/routes/router.gr.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, required this.isFavourite});

  final ProductModel product;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(const ProductRoute()),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            alignment: Alignment.bottomLeft,
            child: TezdaImage(image: product.images.first),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text('\$${product.price}', style: context.textTheme.headlineLarge),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: TezdaColors.light,
              ),
              child: SvgPicture.asset(isFavourite ? TezdaIcons.heart : TezdaIcons.unheart),
            ),
          ),
        ],
      ),
    );
  }
}
