import 'package:creatego/creatego_theme.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

const _testButton = Variant('testButton');

class FXTopBar extends StatelessWidget {
  final Widget? logo;
  final Widget? avatar;
  final bool isTest;
  final VoidCallback? menuOnPressed;
  final VoidCallback? bellIconOnPressed;
  final VoidCallback? popUpMenuOnPressed;
  final VoidCallback? onSearchPressed;
  final TextEditingController? searchController;
  final Color barBgColor;
  final Color barTextColor;
  final double iconSize;
  final String? searchHintText;
  final List<String> navigationList;

  const FXTopBar({
    Key? key,
    this.avatar,
    this.logo,
    this.onSearchPressed,
    this.menuOnPressed,
    this.searchController,
    this.bellIconOnPressed,
    this.navigationList = const [],
    this.popUpMenuOnPressed,
    this.isTest = false,
    this.barBgColor = ThemeColors.finex700,
    this.barTextColor = ThemeColors.white,
    this.iconSize = 24,
    this.searchHintText,
  }) : super(key: key);

  Mix get topBarMix => Mix(
        paddingHorizontal(14),
        height(64),
        bgColor(barBgColor),
        crossAxis(CrossAxisAlignment.center),
        _testButton(
          align(Alignment.center),
          margin(7),
          width(69),
          height(36),
          rounded(6),
          fontSize(15),
          textColor(barTextColor),
          bgColor(ThemeColors.orange500),
        ),
      );

  Mix get searchFieldMix => Mix(
        margin(7),
        height(40),
        width(418),
        rounded(12),
        fontSize(15),
        bgColor(ThemeColors.white),
        align(Alignment.center),
        crossAxis(CrossAxisAlignment.center),
      );

  Mix get topBarRightSide => Mix(
        icon(
          color: barTextColor,
          size: iconSize,
        ),
      );

  Mix get circleAvatarMix => Mix(
        marginLeft(20),
        marginRight(22),
        height(32),
        width(32),
        rounded(360),
      );

  @override
  Widget build(BuildContext context) {
    return Box(
      mix: topBarMix,
      child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpacedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              horizontalSpace: 16,
              children: [
                if (menuOnPressed != null)
                  PressableMix(
                    onPressed: menuOnPressed,
                    child: HeroIcon(
                      HeroIcons.menu,
                      color: barTextColor,
                      size: iconSize,
                    ),
                  ),
                if (navigationList.isNotEmpty)
                  YSBreadcrumbs(
                      routes: navigationList, foregroundColor: barTextColor),
                if (logo != null) logo!,
                if (searchController != null)
                  YSInputfield(
                    bgColor: barTextColor,
                    controller: searchController,
                    prefix: InkWell(
                      child: const HeroIcon(
                        HeroIcons.search,
                        color: Colors.black,
                      ),
                      onTap: onSearchPressed,
                    ),
                    placeholder: searchHintText ?? "",
                    width: 300,
                    height: 40,
                  ),
                // Box(
                //   mix: searchFieldMix,
                //   child: TextField(
                //     controller: searchController,
                //     style: ThemeTextRegular.base.apply(color: Colors.black),
                //     decoration: InputDecoration(
                //       isDense: true,
                //       fillColor: barTextColor,
                //       hintStyle:
                //           ThemeTextRegular.base.apply(color: Colors.black),
                //       hintText: searchHintText,
                //       border: InputBorder.none,
                //       icon: InkWell(
                //         child: const HeroIcon(
                //           HeroIcons.search,
                //           color: Colors.black,
                //         ),
                //         onTap: onSearchPressed,
                //       ),
                //     ),
                //   ),
                // ),
                if (isTest)
                  const Box(
                    variant: _testButton,
                    child: TextMix(
                      'TEST',
                      variant: _testButton,
                    ),
                  ),
              ],
            ),
            Box(
              mix: topBarRightSide,
              child: SpacedRow(horizontalSpace: 16, children: [
                if (bellIconOnPressed != null)
                  PressableMix(
                    mix: topBarRightSide,
                    onPressed: bellIconOnPressed,
                    child: HeroIcon(
                      HeroIcons.bell,
                      color: barTextColor,
                      size: iconSize,
                    ),
                  ),
                if (avatar != null)
                  Box(
                    mix: circleAvatarMix,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: avatar!,
                    ),
                  ),
                if (popUpMenuOnPressed != null)
                  PressableMix(
                    mix: topBarRightSide,
                    onPressed: popUpMenuOnPressed,
                    child: const IconMix(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
              ]),
            ),
          ]),
    );
  }
}
