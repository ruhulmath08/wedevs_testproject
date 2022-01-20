//here we will declare all the API endpoints
//ignore: avoid_classes_with_only_static_members
class ApiEndpoints {
  static const String _baseUrl = 'https://apptest.dokandemo.com/wp-json';

  static String getRegistrationUrl() {
    return '$_baseUrl/wp/v2/users/register';
  }

  static String getLoginUrl() {
    return '$_baseUrl/jwt-auth/v1/token';
  }
}
