const bool _online = true;
const bool ON_EMULATOR = true;
const String _OFFLINE_BASE_URL = "http://tabwa.test/api";
const String _ONLINE_BASE_URL = ON_EMULATOR
    ? "http://tabwa.smirltech.com/api"
    : "https://tabwa.smirltech.com/api";
const String BASE_URL = _online ? _ONLINE_BASE_URL : _OFFLINE_BASE_URL;

// PASSWORD FUNCTIONNALITY
const String FORGOT_PASSWORD_URL = BASE_URL + "/forgot-password";
const String FORGOT_PASSWORD_RESET_URL = BASE_URL + "/forgot-password-reset";
const String PASSWORD_RESET_CONFIRM_CODE_URL =
    BASE_URL + "/password-reset-confirm-code";

// USERS
const String USER_URL = BASE_URL + "/users";
const String LOGIN = BASE_URL + "/login";
const String REGISTER = BASE_URL + "/register";

// WORDS
const String WORDS_URL = BASE_URL + "/words";

// TYPES
const String TYPES_URL = BASE_URL + "/types";

// TRANSLATIONS
const String TRANSLATIONS_URL = BASE_URL + "/translations";

// TRANSLATIONS
const String ADD_AUDIO = BASE_URL + "/audio_add";

// HEADERS

Map<String, String> headers(
    {String? token, String contentType = "application/json"}) {
  return {
    "Content-Type": contentType,
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };
}
