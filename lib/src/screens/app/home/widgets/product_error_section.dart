
import 'package:flutter/material.dart';
import 'package:tezda_shop/theme/theme.dart';

class ProductErrorSection extends StatelessWidget {
  const ProductErrorSection({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: TezdaColors.destructiveAccent),
            const Text('An error occurred'),
            const SizedBox(height: 20),
            SizedBox(width: 150, child: ElevatedButton(onPressed: onPressed, child: const Text('Try again'))),
          ],
        ),
      ),
    );
  }
}
