import '../../../../creatego_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class YSDropwdown extends StatefulWidget {
  final ValueChanged? onChanged;
  final dynamic value;
  final List items;
  final IconData? leftIcon;
  final IconData? rightIcon;
  String? hintText;
  bool isValueNull = false;
  final bool enableBorder;
  final double? dpValWidth;
  final bool hasUnderline;
  final Color buttonBackgroundColor;
  final Color selectedItemBackgroundColor;
  final Color itemBackgroundColor;

  YSDropwdown(
      {required this.items,
      this.onChanged,
      this.enableBorder = false,
      this.buttonBackgroundColor = ThemeColors.white,
      this.itemBackgroundColor = ThemeColors.white,
      this.selectedItemBackgroundColor = ThemeColors.blue400,
      this.dpValWidth,
      this.hasUnderline = true,
      this.value,
      this.leftIcon,
      this.hintText,
      this.rightIcon}) {
    if (value == null) isValueNull = true;
    hintText ??= "Select element";
  }

  @override
  State<YSDropwdown> createState() => _YSDropwdownState();
}

class _YSDropwdownState extends State<YSDropwdown> {
  bool showUnderline = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      dropdownPadding: EdgeInsets.zero,
      itemPadding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      underline: showUnderline
          ? Container(height: 2, color: ThemeColors.blue500)
          : const SizedBox(),
      onChanged: widget.onChanged,
      isExpanded: true,
      onMenuStateChange: (bool changed) {
        if (widget.hasUnderline) {
          setState(() {
            showUnderline = changed;
          });
        }
      },
      style: ThemeTextRegular.base.copyWith(color: ThemeColors.black),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
              color: ThemeColors.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 4)
        ],
      ),
      value: widget.value,
      customButton: Container(
        height: 45,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.buttonBackgroundColor,
          border: Border.all(
              width: widget.enableBorder ? 1 : 0,
              color: widget.enableBorder
                  ? ThemeColors.coolgray300
                  : Colors.transparent),
        ),
        child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.rightIcon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          horizontalSpace: 5,
          children: [
            if (widget.isValueNull)
              ..._buildHint()
            else
              ..._buildSelectedItem(context),
            if (widget.rightIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(widget.rightIcon!,
                    color: showUnderline
                        ? ThemeColors.blue500
                        : (widget.isValueNull
                            ? ThemeColors.gray400
                            : ThemeColors.gray700)),
              ),
          ],
        ),
      ),
      // itemHeight: 56.h,
      items: _getItems(),
    );
  }

  List<Widget> _buildHint() {
    return [
      if (widget.leftIcon != null)
        Icon(widget.leftIcon!,
            color: showUnderline
                ? ThemeColors.blue500
                : (widget.isValueNull
                    ? ThemeColors.gray400
                    : ThemeColors.gray700)),
      if (widget.isValueNull)
        SizedText(
            width: widget.dpValWidth,
            text: widget.hintText,
            textStyle: ThemeTextRegular.base
                .copyWith(color: ThemeColors.black.withOpacity(0.31))),
    ];
  }

  List<Widget> _buildSelectedItem(BuildContext ctx) {
    return [
      if (widget.leftIcon != null)
        Icon(widget.leftIcon!,
            color: showUnderline ? ThemeColors.blue500 : ThemeColors.gray700),
      if (!widget.isValueNull)
        SizedText(width: widget.dpValWidth, text: widget.value.toString()),
    ];
  }

  List<DropdownMenuItem<String>> _getItems() {
    List listValues = widget.items;
    List<DropdownMenuItem<String>> _menuItems = [];
    for (int i = 0; i < listValues.length; i++) {
      _menuItems.add(
        DropdownMenuItem<String>(
          value: listValues[i].toString(),
          child: Container(
            decoration: BoxDecoration(
                color: widget.value == listValues[i]
                    ? widget.selectedItemBackgroundColor
                    : widget.itemBackgroundColor,
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: listValues.length - 1 == i
                            ? ThemeColors.transparent
                            : ThemeColors.gray300.withOpacity(0.5)))),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: double.infinity,
            child: SizedText(
                text: listValues[i].toString(),
                textStyle: ThemeTextRegular.base.apply(
                    color: widget.value == listValues[i]
                        ? ThemeColors.white
                        : ThemeColors.black)),
          ),
        ),
      );
    }

    return _menuItems;
  }
}
