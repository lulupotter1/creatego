import 'package:creatego/creatego_theme.dart';
import 'package:mix/mix.dart';

class YSStatusBadge extends StatelessWidget {
  final String text;
  final double? height;
  bool? isSuccess;
  bool? isError;
  bool? isWarning;
  bool? isProcessing;
  bool? isInactive;
  bool? isSquare;
  final double? width;
  final VoidCallback? onPressed;

  YSStatusBadge({
    required this.text,
    this.height = 32,
    this.width,
    this.onPressed,
    this.isInactive,
    this.isError,
    this.isProcessing,
    this.isSuccess,
    this.isWarning,
    this.isSquare,
  }) {
    isInactive ??= false;
    isError ??= false;
    isProcessing ??= false;
    isSuccess ??= false;
    isWarning ??= false;
    isSquare ??= false;
  }

  Color bgColor = ThemeColors.emerald100;
  Color textColor = ThemeColors.emerald800;

  Mix get pressableMix => Mix(
      animated(),
      rounded(6),
      scale(1),
      press(
        scale(.95),
      ));
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    _buildStatus();
    return PressableMix(
      onPressed: onPressed,
      mix: pressableMix,
      child: Container(
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSquare! ? 4 : _width / 2),
          color: bgColor,
        ),
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Text(
          text,
          style: ThemeTextRegular.xxs.apply(color: textColor),
        ),
      ),
    );
  }

  _buildStatus() {
    if (isInactive!) {
      bgColor = ThemeColors.coolgray200;
      textColor = ThemeColors.coolgray800;
    } else if (isError!) {
      bgColor = ThemeColors.red200;
      textColor = ThemeColors.red800;
    } else if (isWarning!) {
      bgColor = ThemeColors.amber200;
      textColor = ThemeColors.amber800;
    } else if (isProcessing!) {
      bgColor = ThemeColors.blue200;
      textColor = ThemeColors.blue800;
    }
  }
}
