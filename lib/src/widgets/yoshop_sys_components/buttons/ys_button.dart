import 'package:mix/mix.dart';

import '../../../../creatego_theme.dart';

class YSButton extends StatelessWidget {
  // final double width;
  // final double height;
  final String text;
  final IconData? icon;
  final double? iconsize;
  final bool isIconRight;
  final VoidCallback? onPressed;

  ///In order to change button size, padding must be edited
  EdgeInsets padding;
  final Color bgColor;
  final Color textColor;
  Color borderColor = ThemeColors.transparent;
  int el = 1;

  YSButton(
      {Key? key,
      // thisidth = 94,
      // thiseight = 30,
      this.onPressed,
      this.icon,
      this.bgColor = ThemeColors.orange500,
      this.textColor = ThemeColors.white,
      this.iconsize,
      required this.text,
      this.isIconRight = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 5)})
      : super(key: key);

  YSButton.secondary(
      {Key? key,
      // thisidth = 94,
      // thiseight = 30,
      this.onPressed,
      this.icon,
      this.iconsize,
      required this.text,
      this.isIconRight = false,
      this.bgColor = ThemeColors.orange100,
      this.textColor = ThemeColors.orange500,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 5)})
      : super(key: key);

  YSButton.ghost(
      {Key? key,
      // thisidth = 94,
      // thiseight = 30,
      this.onPressed,
      this.icon,
      this.iconsize,
      this.el = 1,
      required this.text,
      this.bgColor = ThemeColors.white,
      this.textColor = ThemeColors.coolgray600,
      this.isIconRight = false,
      this.borderColor = ThemeColors.coolgray300,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 5)})
      : super(key: key);

  YSButton.link(
      {Key? key,
      // thisidth = 94,
      // thiseight = 30,
      this.onPressed,
      this.icon,
      this.iconsize,
      required this.text,
      this.bgColor = ThemeColors.transparent,
      this.textColor = ThemeColors.orange500,
      this.isIconRight = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 5)})
      : super(key: key) {
    el = 0;
  }

  Mix get pressableMix => Mix(
      animated(),
      elevation(el),
      rounded(6),
      scale(1),
      hover(
        elevation(el == 0 ? 0 : 2),
      ),
      press(
        scale(.95),
      ));

  Mix get boxMix => Mix(
      rounded(6),
      paddingHorizontal(padding.horizontal),
      paddingVertical(padding.vertical),
      border(width: 1, color: borderColor),
      BoxAttributes(
        color: bgColor,
      ));

  Mix get textMix => Mix(textStyle(
        ThemeTextSemiBold.sm.apply(color: textColor),
      ));

  Mix get iconMix => Mix(
        iconSize(iconsize != null ? iconsize! : 16),
        iconColor(textColor),
      );

  @override
  Widget build(BuildContext context) {
    return PressableMix(
        mix: pressableMix,
        onPressed: onPressed,
        child: Box(
          mix: boxMix,
          child: SpacedRow(
            horizontalSpace: 6,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isIconRight)
                if (icon != null) IconMix(icon!, mix: iconMix),
              TextMix(
                text,
                mix: textMix,
              ),
              if (isIconRight)
                if (icon != null) IconMix(icon!, mix: iconMix),
            ],
          ),
        ));
  }
}
