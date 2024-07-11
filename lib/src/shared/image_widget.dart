import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/config.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

class TezdaImage extends StatelessWidget {
  const TezdaImage({super.key, required this.image, this.radius, this.height, this.width});
  final String image;
  final double? radius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return runningTests
        ? Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(TezdaIcons.emptyPictureIcon),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FancyShimmerImage(
              imageUrl: image,
              shimmerBaseColor: TezdaColors.neutral,
              shimmerBackColor: TezdaColors.secondary,
              boxFit: BoxFit.cover,
              errorWidget: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(TezdaIcons.emptyPictureIcon),
              ),
            ),
          );
  }
}
