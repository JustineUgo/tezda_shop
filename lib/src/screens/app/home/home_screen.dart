import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/brand_section.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_error_section.dart';
import 'package:tezda_shop/src/screens/app/home/widgets/product_list_section.dart';
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
      ref.read(homeInfoProvider.notifier).loadMore();
    }
  }

  void onTapCategory(int id) {
    if (id == 0) {
      final res = ref.refresh(homeInfoProvider.future);
      res;
    } else {
      ref.read(homeInfoProvider.notifier).filterProductsByCategory(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(homeInfoProvider);
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
            Expanded(
              child: switch (productsState) {
                AsyncData(:HomeInfoData value) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandSection(value: value, onTap: (id) => onTapCategory(id)),
                      const SizedBox(height: 10),
                      Expanded(
                        child: value.products.isEmpty
                            ? const Center(
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('There are no products ')]),
                              )
                            : ProductListSection(onRefresh: () => ref.refresh(homeInfoProvider.future), scrollController: _scrollController, value: value),
                      ),
                    ],
                  ),
                AsyncError() => ProductErrorSection(onPressed: () => ref.refresh(homeInfoProvider.future)),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
