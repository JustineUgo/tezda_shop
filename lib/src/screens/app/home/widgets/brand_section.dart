
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/models/product/product_model.dart';
import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/theme/theme.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key, required this.value, required this.onTap});
  final HomeInfoData value;
  final Function(int id) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [const Category(id: 0, name: 'All', image: ''), ...value.categories].map(
            (category) {
              bool isSelected = (value.categoryFilter ?? 0) == category.id;
              return InkWell(
                onTap: () => onTap(category.id),
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: TezdaColors.dark),
                        )
                      : null,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    category.name,
                    style: isSelected ? context.textTheme.headlineLarge!.copyWith(fontSize: 18) : context.textTheme.titleSmall!.copyWith(fontSize: 18),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
