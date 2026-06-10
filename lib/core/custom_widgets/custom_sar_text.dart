import 'package:car/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ValueWithCurrencyIcon extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double iconSize;

  const ValueWithCurrencyIcon({super.key, required this.text, this.textStyle, this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    final style = textStyle ?? DefaultTextStyle.of(context).style;
    final parts = text.split(RegExp(r'\s*ر\.س\s*'));

    if (parts.length == 1) {
      return Text(text, style: style);
    }

    final children = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        children.add(TextSpan(text: parts[i], style: style));
      }
      if (i < parts.length - 1) {
        children.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SvgPicture.asset(
              AppImages.sar,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(style.color ?? Colors.black, BlendMode.srcIn),
            ),
          ),
        );
      }
    }

    return RichText(text: TextSpan(children: children));
  }
}
