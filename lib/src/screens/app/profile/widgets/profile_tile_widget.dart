import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/theme/theme.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.text, required this.icon, this.color = TezdaColors.primary, this.trailing = const SizedBox()});
  final String text;
  final String icon;
  final Widget trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(.3), shape: BoxShape.circle),
            child: SvgPicture.asset(icon),
          ),
          Expanded(child: Text(text, style: context.textTheme.bodyLarge)),
          trailing,
        ],
      ),
    );
  }
}
