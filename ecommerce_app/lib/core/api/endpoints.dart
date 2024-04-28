class EndPoints {
  static String baseUrl = "https://fakestoreapi.com/";
  static String signin = "auth/login";
  static String signup = "user/signup";
  static String getUserEndPoint(int id) {
    return "${EndPoints.baseUrl}users/$id";
  }
}

class ApiKey {
  static String token = "token";
  static String statusCode = "status";
  static String errorMessage = "ErrorMessage";
  static String id = "id";
  static String email = "email";
  static String password = "password";
  static String username = "username";
}
