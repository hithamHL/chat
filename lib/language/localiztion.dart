


import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../utils/my_string.dart';
import 'ar.dart';
import 'en.dart';
import 'fr.dart';

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ene: en,
        ara: ar,
        frf: fr,
      };
}
