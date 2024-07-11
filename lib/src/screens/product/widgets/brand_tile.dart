
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';

class BrandTile extends StatelessWidget {
  const BrandTile({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: TezdaColors.light,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text('Brand'),
              Text('Clothing', style: context.textTheme.headlineMedium),
            ],
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: TezdaImage(image: image),
          ),
        ],
      ),
    );
  }
}
