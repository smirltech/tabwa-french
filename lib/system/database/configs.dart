const bool _online = true;
const String _OFFLINE_BASE_URL = "http://tabwa.test/api";
const String _ONLINE_BASE_URL = "http://tabwa.smirltech.com/api";
const String BASE_URL = _online ? _ONLINE_BASE_URL : _OFFLINE_BASE_URL;

// USERS
const String USER_URL = BASE_URL + "";
const String LOGIN = USER_URL + "/login";
const String REGISTER = USER_URL + "/register";

// WORDS
const String WORDS_URL = BASE_URL + "/words";

// TYPES
const String TYPES_URL = BASE_URL + "/types";

// TRANSLATIONS
const String TRANSLATIONS_URL = BASE_URL + "/translations";

// HEADERS

Map<String, String> headers({String? token}) {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };
}
