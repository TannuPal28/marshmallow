class ApiConstants {
  /// BASE URL
  static const String baseUrl = "https://enterprise-e-com.onrender.com/v1/user";

  /// USER API
  // static const String userBaseUrl = "$baseUrl";

  static const String productList = "/product";
  static const String bannerList = "/banner/list";
  static const String categoryMenuList = "/categoryMenu/tree";

  static const String register = "/register";
  static const String verifyOtp = "/verifyOTP";
  static const String verifyLoginOtp = "/verifyLoginOtp";
  static const String login = "/login";
  static const String forgotPassword = "/forgotPassword";
  static const String verifyUserForgotPasswordOTP =
      "/verifyUserForgotPasswordOTP";
  static const String resetPassword = "/resetPassword";

  /// SELLER API
  static const String merchantBaseUrl =
      "https://enterprise-e-com.onrender.com/v1/merchant/user";

  static const String sellerRegister = "/register";

  /// LOCATION API
  static const String nominatimBaseUrl = "https://nominatim.openstreetmap.org";

  static const String searchLocation = "/search";
  static const String reverseLocation = "/reverse";

  static String productDetail(String productId) => "/product/$productId";

  static String similarProductList(String categoryId, String productId) =>
      "/product/similarProduct/$categoryId/$productId";
  static String addToCart = "/cart/add";

  static String updateCart(String cartItemId) =>
      "/cart/update/$cartItemId";

  static const String getCart = "/cart";
  static  String removeCart(String cartItemId) =>  '/cart/remove/$cartItemId';
  static  String wishlistAdd =  '/wishlist/add';
  static  String wishlistRemove =  '/wishlist/remove';
  static const String getWishlist = "/wishlist";
  static const String getAddress = "/address";
  static const String getCoupons = "/coupons/active";
}
