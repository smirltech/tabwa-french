import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "menu": "Menu",
          "login": "Login",
          "register": "Register",
          "logout": "Logout",
          "home": "Home",
          "profile": "Profile",
          "settings": "Settings",
          "about": "About",
          "name": "Name",
          "email": "Email",
          "password": "Password",
          "confirm password": "Confirm Password",
          'tabwa french dictionnary': 'Tabwa French Dictionnary',
        },
        'fr_FR': {
          "menu": "Menu",
          "login": "Se connecter",
          "register": "S'inscrire",
          "logout": "Se déconnecter",
          "home": "Accueil",
          "profile": "Profil",
          "settings": "Paramètres",
          "about": "À propos",
          "name": "Nom",
          "email": "Email",
          "password": "Mot de passe",
          "confirm password": "Confirmer le mot de passe",
          'tabwa french dictionnary': 'Dictionnaire Tabwa Français',
        }
      };
}
