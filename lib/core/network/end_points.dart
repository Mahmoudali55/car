class EndPoints {
  static const String login = 'token';
  static const String users = 'users';
  static String detailsUser(int id) => '$users/$id';
}
