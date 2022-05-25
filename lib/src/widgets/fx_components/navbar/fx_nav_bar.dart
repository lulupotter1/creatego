import 'package:creatego/creatego_theme.dart';
import 'package:mix/mix.dart';
import 'package:flutter/material.dart';

const _navBarPadding = Variant('navBarPadding');

class FXNavBar extends StatelessWidget {
  final Color backGroundColor;
  final int currentIndex;
  final Function(int)? onTabChange;
  final List<Widget> children;

  const FXNavBar({
    Key? key,
    required this.children,
    this.onTabChange,
    required this.currentIndex,
    this.backGroundColor = ThemeColors.finex600,
  }) : super(key: key);

  Mix get fxNavBarMix => Mix(
        height(64),
        _navBarPadding(
          paddingHorizontal(24),
          paddingVertical(11),
        ),
        bgColor(backGroundColor),
        textColor(ThemeColors.white),
        fontSize(14),
        fontWeight(FontWeight.w500),
      );

  @override
  Widget build(BuildContext context) {
    return Box(
      mix: fxNavBarMix,
      variant: _navBarPadding,
      child: SpacedRow(
        children: _buildNavbarChildren(context),
        horizontalSpace: 20,
      ),
    );
  }

  List<Widget> _buildNavbarChildren(BuildContext context) {
    final List<Widget> buttons = [];
    for (int i = 0; i < children.length; i++) {
      final _item = children[i];
      buttons.add(
        _checkActive(
          context,
          currentIndex,
          i,
          _item,
          onTabChange,
        ),
      );
    }
    return buttons;
  }

  _checkActive(BuildContext context, int currentIndex, int childrenIndex,
      Widget item, Function(int)? onPressed) {
    if (item is YSButton) {
      if (currentIndex == childrenIndex) {
        return YSButton(
          text: item.text,
          icon: item.icon,
          bgColor: item.bgColor,
          onPressed: () {
            onPressed?.call(childrenIndex);
          },
        );
      } else {
        return YSButton.link(
          text: item.text,
          icon: item.icon,
          textColor: ThemeColors.white,
          onPressed: () {
            onPressed?.call(childrenIndex);
          },
        );
      }
    } else {
      return item;
    }
  }
}
