// environment class
// ignore_for_file: constant_identifier_names

class Environment {
  static const String GOOGLE_API_URL = 'https://api.themoviedb.org/3';
  static const String API_KEY = 'b4d0f6e2e0e2c4b2b2e2e0e2c4b2b2e2';
  static const String IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  static const String LANGUAGE = 'en-US';

  static const String BASE_URL = 'https://hva-backend.onrender.com/api/';

  // USERS URLS
  static const String USERS_URL = '${BASE_URL}user';
  static const String GET_USER_URL = '$USERS_URL/';
  static const String UPDATE_USER_URL = '$USERS_URL/';
  static const String DELETE_USER_URL = '$USERS_URL/';
  static const String UPDATE_PASSWORD_URL = '$USERS_URL/update-password';

  // AUTH URLS
  static const String LOGIN_URL = '$USERS_URL/signin';
  static const String REGISTER_URL = '$USERS_URL/signup';
  static const String OTP_URL = '$USERS_URL/otp';
}
