import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'tabwa french dictionnary': 'Tabwa French Dictionnary',
        },
        'fr_FR': {
          'tabwa french dictionnary': 'Dictionnaire Tabwa Français',
          'hello': 'Salut',
        }
      };
}
