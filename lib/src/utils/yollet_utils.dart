import '../../creatego_theme.dart';
import 'get_yollet_variants.dart';

class WidgetParser {
  static List<Widget> parseWidgetFromMap(Map jsonObject) {
    List<Widget> list = [];
    for (int i = 0; i < jsonObject.keys.length; i++) {
      Map jsonObjectParams = jsonObject[jsonObject.keys.toList()[i]];
      String widgetName = jsonObject.keys.toList()[i];
      list.add(_getWidget(jsonObjectParams, widgetName));
    }

    return list.reversed.toList();
  }
}

Widget _getWidget(Map params, String widgetName) {
  switch (widgetName) {
    case "SizedText":
      return SizedText(
        text: params['text'],
        height: params['height'],
        width: params['width'],
        alignment: getAlignment(params['alignment']),
        textAlign: getTextAlign(params['textAlign']),
        maxLines: params['maxLines'],
        useLocaleText: params['useLocaleText'],
      );
    default:
      return const Text(
        'New text widget',
        style: TextStyle(color: Colors.redAccent),
      );
  }
}
