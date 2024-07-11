import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_widget.dart';
import 'package:tezda_shop/theme/theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String image =
        'https://external-content.duckduckgo.com/iu?u=https%3A%2F%2Fimages.wallpapersden.com%2Fimage%2Fdownload%2Fwinking-anime-girl_a2xtZ2yUmZqaraWkpJRobWlmrWlla2Y.jpg&f=1&nofb=1&ipt=df879dd8d9dd11a23bdb40523b25a88353e5052cf2cb6537b3038e0df63afc21&ipo=images';
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text('Discover', style: context.textTheme.titleLarge),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Clothes', 'Electronics', 'Furniture', 'Shoes']
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(category, style: context.textTheme.headlineLarge!.copyWith(fontSize: 18)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: List.generate(20, (index) {
                  return ProductWidget(image: image);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
