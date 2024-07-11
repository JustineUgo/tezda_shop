import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

@RoutePage()
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(TezdaIcons.emptyIcon, height: 50),
                    Text('You have not added any product your wishlist', style: context.textTheme.bodyLarge),
                  ],
                ),
              ),
              // GridView.count(
              //   crossAxisCount: 2,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   children: List.generate(20, (index) {
              //     return ProductWidget(image: image);
              //   }),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
