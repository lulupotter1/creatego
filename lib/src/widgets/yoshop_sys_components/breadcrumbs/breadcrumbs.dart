import '../../../../creatego_theme.dart';

class YSBreadcrumbs extends StatelessWidget {
  final List<String> routes;
  final Color foregroundColor;
  YSBreadcrumbs(
      {Key? key,
      required this.routes,
      this.foregroundColor = ThemeColors.coolgray500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildRoutes(context),
    );
  }

  List<Widget> _buildRoutes(BuildContext context) {
    List<Widget> list = [];
    for (var element in routes) {
      list.add(Text(
          // element,
          element.toString(),
          style: ThemeTextRegular.xs.apply(
            color: foregroundColor,
          )));
      list.add(const SizedBox(
        width: 8,
      ));
      if (routes.last != element) {
        list.add(HeroIcon(
          HeroIcons.chevronRight,
          color: foregroundColor,
          size: 20,
          solid: true,
        ));
        list.add(const SizedBox(
          width: 8,
        ));
      }
    }
    return list;
  }
}
