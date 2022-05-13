import 'package:creatego/creatego_theme.dart';
import 'package:mix/mix.dart';

class FxToast extends StatelessWidget {
  final ToastType toastType;
  final String toastTitle;
  final String toastMessage;
  const FxToast({
    Key? key,
    this.toastType = ToastType.success,
    required this.toastMessage,
    required this.toastTitle,
  }) : super(key: key);

  Mix get toastMix => Mix(
        width(320),
        shadow(
          blurRadius: 26,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          color: _getShadowColor(toastType),
        ),
        border(color: _getBgColor(toastType), width: 1),
        paddingHorizontal(12),
        paddingVertical(12),
        rounded(6),
        bgColor(_getBgColor(toastType)),
      );

  Mix get _toastTitleVariant => Mix(
        textStyle(const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "NotoSansMedium",
          fontStyle: FontStyle.normal,
          fontSize: 16.0,
        )),
        marginBottom(2),
      );
  Mix get _toastMessageVariant => Mix(
        textStyle(ThemeTextRegular.sm),
      );

  @override
  Widget build(BuildContext context) {
    return Box(
      mix: toastMix,
      child: toastMix.row(children: [
        HeroIcon(
          _getIcons(toastType),
          size: 32,
        ),
        toastMix.column(children: [
          TextMix(toastTitle, mix: _toastTitleVariant),
          TextMix(toastMessage, mix: _toastMessageVariant),
        ]),
        const Spacer(),
        const HeroIcon(
          HeroIcons.x,
          size: 16,
        ),
      ]),
    );
  }

  _getBgColor(ToastType toastType) {
    switch (toastType) {
      case ToastType.error:
        return const Color(0xFFEB5757); //added by Galymzhan red color
      case ToastType.warning:
        return ThemeColors.finex500;
      default:
        return ThemeColors.finex600;
    }
  }

  _getShadowColor(ToastType toastType) {
    switch (toastType) {
      case ToastType.error:
        return const Color(0xFFD70000)
            .withOpacity(0.1); //added by Galymzhan red color
      case ToastType.warning:
        return const Color(0xFFD70000).withOpacity(0.1);
      default:
        return const Color(0xFF52D700).withOpacity(0.1);
    }
  }

  _getIcons(ToastType toastType) {
    //need to add icons like success, error, warning
    switch (toastType) {
      case ToastType.error:
        return HeroIcons.checkCircle;
      case ToastType.warning:
        return HeroIcons.cake;

      default:
        return HeroIcons.wifi;
    }
  }
}

enum ToastType { success, error, warning }
