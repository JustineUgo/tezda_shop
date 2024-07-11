
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          alignment: Alignment.bottomLeft,
          child: TezdaImage(image: image),
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
              child: Text('\$400', style: context.textTheme.headlineLarge),
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
            child: SvgPicture.asset(TezdaIcons.unheart),
          ),
        ),
      ],
    );
  }
}
