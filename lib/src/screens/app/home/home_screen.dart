import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_widget.dart';
import 'package:tezda_shop/theme/theme.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(productListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productListProvider);
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
              child: switch (productsState) {
                AsyncData(:ProductListData value) => RefreshIndicator(
                    onRefresh: () => ref.refresh(productListProvider.future),
                    child: GridView.count(
                      controller: _scrollController,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: List.generate(value.products.length, (index) {
                        if (!value.isFinished && index == value.products.length - 1) return const Center(child: CircularProgressIndicator());
                        return ProductWidget(product: value.products[index]);
                      }),
                    ),
                  ),
                AsyncError() => Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: TezdaColors.destructiveAccent),
                          const Text('An error occurred'),
                          const SizedBox(height: 20),
                          SizedBox(width: 150, child: ElevatedButton(onPressed: () => ref.refresh(productListProvider.future), child: const Text('Try again'))),
                        ],
                      ),
                    ),
                  ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
