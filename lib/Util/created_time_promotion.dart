import 'package:aviz/Di/di.dart';
import 'package:translator/translator.dart';
import 'package:timeago/timeago.dart' as timeago;

class CreatedAtPromotion {
  static Future<String> createdTime(String creatAt) async {
    final translator = locator.get<GoogleTranslator>();
    DateTime createdAt = DateTime.parse(creatAt);
    String timeElapsed = timeago.format(createdAt, locale: 'fa');
    var timeToPersion = await translator.translate(timeElapsed, to: 'fa');
    return timeToPersion.toString();
  }
}
