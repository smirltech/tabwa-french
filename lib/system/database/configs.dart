const bool _online = false;
const String _OFFLINE_BASE_URL = "http://tabwa.test/api";
const String _ONLINE_BASE_URL = "";
const String BASE_URL = _online ? _ONLINE_BASE_URL : _OFFLINE_BASE_URL;

// USERS
const String USER_URL = BASE_URL + "";
const String LOGIN = USER_URL + "/login";
const String REGISTER = USER_URL + "/regiser";

// WORDS
const String WORDS_URL = BASE_URL + "/words";
