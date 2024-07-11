import 'package:flutter/cupertino.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(right: 15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: TezdaImage(image: image),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nolan Carder', style: context.textTheme.headlineMedium),
                    const Text('Today'),
                  ],
                ),
                Row(
                  children: List.generate(5, (index) => const Icon(CupertinoIcons.star_fill, color: TezdaColors.yellow)),
                ),
                const SizedBox(height: 10),
                Text('Perfect for keeping your feet dry and warm in damp conditions. ', style: context.textTheme.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
