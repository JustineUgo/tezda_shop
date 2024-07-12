import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/screens/product/widgets/brand_tile.dart';
import 'package:tezda_shop/src/screens/product/widgets/review_tile.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    String image =
        'https://external-content.duckduckgo.com/iu?u=https%3A%2F%2Fimages.wallpapersden.com%2Fimage%2Fdownload%2Fwinking-anime-girl_a2xtZ2yUmZqaraWkpJRobWlmrWlla2Y.jpg&f=1&nofb=1&ipt=df879dd8d9dd11a23bdb40523b25a88353e5052cf2cb6537b3038e0df63afc21&ipo=images';

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
                        child: TezdaImage(image: image),
                      ),
                      const SizedBox(height: 20),
                      Text('Product name', style: context.textTheme.titleLarge),
                      Text('5.0 (3 Reviews)', style: context.textTheme.bodyMedium),
                      const SizedBox(height: 5),
                      Text('\$400', style: context.textTheme.titleMedium),
                      const SizedBox(height: 20),
                      Text('Description', style: context.textTheme.headlineLarge),
                      const SizedBox(height: 10),
                      const Text(
                          "Engineered to crush any movement-based workout, these On sneakers enhance the label's original Cloud sneaker with cutting edge technologies for a pair. "),
                      const SizedBox(height: 20),
                      Text('Review (3)', style: context.textTheme.headlineLarge),
                      const SizedBox(height: 10),
                      ReviewTile(image: image),
                      ReviewTile(image: image),
                      ReviewTile(image: image),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            BrandTile(image: image),
          ],
        ),
      ),
    );
  }
}
