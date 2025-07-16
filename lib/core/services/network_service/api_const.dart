final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);
  static const Duration receiveTimeout = Duration(minutes: 1);

  static const String baseUrl = "https://back.stroybazan1.uz";
  static const String apiProduct = "/api/api/products/";
  static const String apiSingleProduct = "/api/api/products/";
  static const String apiBanner = "/api/api/banners/";
  static const String apiOrderCreate = "/api/api/orders/create/";

// Query parameters
  static final Map<String, String> param = {
    "Content-Type": "application/json",
  };
}

final class ApiParams {
  const ApiParams._();

  // Method to generate authorization header
  static Map<String, String> authorizationHeader() => {
        "Authorization": "Bearer ",
        "Content-Type": "application/json",
      };

  // Parameters for sending SMS verification code
  static Map<String, dynamic> cabinetSmsCheckParams({
    required String phone,
    required String code,
  }) =>
      <String, dynamic>{
        "phone": phone,
        "code": code,
      };

  // Empty parameter map when no additional parameters are needed
  static Map<String, dynamic> emptyParams() => <String, dynamic>{};

  static Map<String, dynamic> productBranchParam(int branch) => <String, dynamic>{"branch": branch};

  // Query parameters for requesting a movie list with pagination
  static Map<String, dynamic> param({required int page}) => {};
}
