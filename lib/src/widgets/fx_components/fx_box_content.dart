import 'package:creatego/creatego_utils.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:creatego/creatego_theme.dart';

const _boxVariant = Variant('boxVariant');

class FXBoxContent extends StatelessWidget {
  final double height;
  final String titleText;
  final HeroIcons icon;
  String? subtitle;
  final int totalValue;
  final Color backGroundColor;
  final Color txtColor;
  final Color totalValueColor;
  final Color iconBorderColor;
  final Color iconColor;

  FXBoxContent({
    Key? key,
    this.height = 88,
    this.iconColor = ThemeColors.amber500,
    this.iconBorderColor = ThemeColors.amber500,
    this.totalValueColor = ThemeColors.coolgray700,
    this.txtColor = ThemeColors.gray400,
    required this.totalValue,
    required this.icon,
    required this.titleText,
    this.backGroundColor = ThemeColors.white,
    this.subtitle,
  }) : super(key: key);

  Mix get FXBoxContentMix => Mix(
        rounded(6),
        fontSize(32),
        scale(1),
        _boxVariant(
          border(color: ThemeColors.coolgray200, width: 1),
          paddingVertical(16),
          paddingHorizontal(25),
          shadow(
              color: ThemeColors.black.withOpacity(0.07),
              offset: const Offset(0, 1),
              blurRadius: 2.0),
        ),
        bgColor(backGroundColor),
        textColor(totalValueColor),
        fontWeight(FontWeight.bold),
        // mainAxis(MainAxisAlignment.spaceBetween),
        crossAxis(CrossAxisAlignment.baseline),
      );

  Mix get FXBoxColumn => Mix(
        fontSize(15),
        textColor(txtColor),
        mainAxis(MainAxisAlignment.center),
        crossAxis(CrossAxisAlignment.start),
      );

  Mix get FXBoxIcon => Mix(
        rounded(360),
        paddingVertical(11.66),
        paddingHorizontal(13.2),
        border(
          color: iconBorderColor,
          width: 3,
        ),
      );

  Mix get customRow => Mix();

  @override
  Widget build(BuildContext context) {
    return Box(
      mix: FXBoxContentMix,
      variant: _boxVariant,
      child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Box(
              mix: FXBoxContentMix,
              child: customRow.row(children: [
                Box(
                  mix: FXBoxIcon,
                  child: HeroIcon(
                    icon,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 20),
                FXBoxColumn.column(
                  children: [
                    TextMix(titleText),
                    if (subtitle != null) const SizedBox(height: 6),
                    if (subtitle != null) TextMix(subtitle!),
                  ],
                ),
              ]),
            ),
            const SizedBox(width: 15),
            TextMix(
              currencyFormatter(
                totalValue,
                withSymbol: false,
              ),
            ),
          ]),
    );
  }
}
