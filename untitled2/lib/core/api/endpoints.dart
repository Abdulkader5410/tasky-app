
class EndPoints {

  static String baseUrl = "https://todo.iraqsapp.com/";
  static String signin = "auth/login/";
  static String signup = "auth/register/";
  static String profile = "auth/profile";
  static String logout = "auth/logout";
  static String addTask = "todos";

  // static String products = "products/";
  // static String categories = "categories/";
  // static String category = "category/";
  static String users = "users/";
  // static String cart = "cart/";
  // static String carts = "carts/";
  static String user = "user/";
  static String addUser = "${EndPoints.users}/add";
  // static String addPro = "${EndPoints.products}/add";
  // static String addCart = "${EndPoints.cart}/add";
  // static String updateCart = "${EndPoints.carts}/";
  // static String deleteCart = "${EndPoints.carts}/";

  static String getUserEndPoint(int id) {
    return "${EndPoints.baseUrl}users/$id";
  }

  // static String getProByCategEndPoint(String name) {
  //   return "${EndPoints.baseUrl}${EndPoints.products}${EndPoints.category}$name";
  // }
}

class ApiKey {
  static String token = "token";
  static String refreshToken = "refresh_token";
  static String accessToken= "access_token";
  static String statusCode = "status";
  static String errorMessage = "ErrorMessage";
  static String id = "userId";
  static String username = "username";
  static String password = "password";
  static String displayName = "displayName";
  static String experienceYears = "experienceYears";
  static String level = "level";
  static String address= "address";
  static String phone= "phone";

  static String image= "image";
  static String title= "title";
  static String desc= "desc";
  static String priority= "priority";
  static String dueDate= "dueDate";
  
}
