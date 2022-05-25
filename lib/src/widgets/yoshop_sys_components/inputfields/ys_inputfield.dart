import 'package:flutter/services.dart';
import '../../../../creatego_theme.dart';

class YSInputfield extends StatelessWidget {
  final InputType inputType;
  final String placeholder;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final bool enableBorder;
  final int? maxlines;
  final InputSize inputSize;
  final ValueChanged? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final String suffixText;
  final String prefixText;
  final bool isOrange;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final double borderRadius;
  final bool enableShadow;
  final TextStyle? controllerStyle;
  final int? maxLength;
  final FocusNode? focusNode;
  final Widget? suffix;
  final Color? bgColor;

  YSInputfield({
    Key? key,
    this.onEditingComplete,
    this.suffix,
    this.focusNode,
    this.maxLength,
    this.inputType = InputType.Main,
    this.placeholder = '',
    this.validator,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onTap,
    this.maxlines,
    this.textInputAction,
    this.enableBorder = false,
    this.onChanged,
    this.inputSize = InputSize.M,
    this.suffixText = '',
    this.prefixText = '',
    this.isOrange = false,
    this.inputFormatters,
    this.obscureText = false,
    this.borderRadius = 24,
    this.enableShadow = false,
    this.controllerStyle,
    this.bgColor = ThemeColors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = _getSize();
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      shadowColor: ThemeColors.black.withOpacity(0.07),
      child: Container(
        // height: size.height.h,
        decoration: enableShadow
            ? BoxDecoration(
                border: Border.all(width: 1, color: ThemeColors.coolgray100),
                boxShadow: ThemeShadows.shadowSm,
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        width: size.width,
        child: TextFormField(
          focusNode: focusNode,
          autofocus: false,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          textAlign:
              inputType == InputType.Number ? TextAlign.right : TextAlign.start,
          cursorColor: ThemeColors.coolgray900,
          style: controllerStyle != null
              ? controllerStyle
              : inputType == InputType.Number
                  ? ThemeTextMedium.xl5
                  : ThemeTextRegular.xl3.copyWith(
                      color: inputType == InputType.Disabled
                          ? ThemeColors.coolgray500
                          : ThemeColors.coolgray900),
          validator: validator,
          controller: controller,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          maxLines: maxlines,
          keyboardType: keyboardType,
          readOnly: inputType == InputType.Disabled,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 20),
              child: suffix,
            ),
            suffixIconConstraints: BoxConstraints.tightFor(height: 44),
            prefix: SizedText(
              text: prefixText,
              textStyle:
                  ThemeTextBold.xl3.apply(color: ThemeColors.coolgray900),
            ),
            filled: true,
            fillColor: bgColor,
            hintText: placeholder,
            hintStyle:
                ThemeTextRegular.xl2.copyWith(color: ThemeColors.coolgray500),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: enableBorder
                  ? const BorderSide(color: ThemeColors.coolgray200, width: 1)
                  : const BorderSide(color: ThemeColors.transparent, width: 0),
            ),
            errorStyle: ThemeTextRegular.lg,
            errorMaxLines: 2,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: enableBorder
                  ? BorderSide(
                      color: isOrange
                          ? ThemeColors.orange500
                          : ThemeColors.coolgray200,
                      width: 1)
                  : const BorderSide(color: ThemeColors.transparent, width: 0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: enableBorder
                  ? BorderSide(color: ThemeColors.red200, width: 2)
                  : const BorderSide(color: ThemeColors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: enableBorder
                  ? BorderSide(
                      color: isOrange
                          ? ThemeColors.orange500
                          : ThemeColors.coolgray200,
                      width: 1)
                  : const BorderSide(color: ThemeColors.transparent, width: 0),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: inputSize == InputSize.L ? 30 : 20),
            suffix: SizedText(
              text: suffixText,
              textStyle:
                  ThemeTextMedium.xl3.apply(color: ThemeColors.coolgray900),
            ),
          ),
        ),
      ),
    );
  }

  Size _getSize() {
    Size size = const Size(522, 80);
    switch (inputSize) {
      case InputSize.L:
        size = const Size(656, 97);
        break;
      case InputSize.L2:
        size = const Size(576, 84);
        break;
      case InputSize.M:
        size = const Size(522, 80);
        break;
      case InputSize.S:
        size = const Size(262, 80);
        break;
    }
    return size;
  }
}

enum InputType { Main, Disabled, Number }
enum InputSize { L, M, S, L2 }
