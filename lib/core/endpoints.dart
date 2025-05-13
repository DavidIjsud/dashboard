class Endpoints {
  Endpoints({
    required this.getUsersEndPoint,
    required this.getOrdersEndPoint,
    required this.getProductsEndPoint,
    required this.getCategoriesEndPoint,
  });

  final String getUsersEndPoint;
  final String getOrdersEndPoint;
  final String getProductsEndPoint;
  final String getCategoriesEndPoint;

  factory Endpoints.fromJson(Map<String, dynamic> json) {
    return Endpoints(
      getUsersEndPoint: json[_AttributesKeys.loginEndPoint],
      getOrdersEndPoint: json[_AttributesKeys.getOrdersEndPoint],
      getProductsEndPoint: json[_AttributesKeys.getProductsEndpoint],
      getCategoriesEndPoint: json[_AttributesKeys.getCategoriesEndPoint],
    );
  }
}

abstract class _AttributesKeys {
  static const String loginEndPoint = 'getUsersEndPoint';
  static const String getOrdersEndPoint = 'getOrdersEndPoint';
  static const String getProductsEndpoint = 'getProductsEndPoint';
  static const String getCategoriesEndPoint = 'getCategoriesEndPoint';
}
