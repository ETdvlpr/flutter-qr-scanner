import 'package:get/get.dart';
import 'package:scanner/shared/translations/am_translation.dart';
import 'package:scanner/shared/translations/ar_translation.dart';
import 'package:scanner/shared/translations/en_us_translation.dart';
import 'package:scanner/shared/translations/sw_translation.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'am': am,
        'ar': ar,
        'sw': sw,
      };
}
