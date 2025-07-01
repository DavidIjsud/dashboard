class Endpoints {
  Endpoints({
    required this.getUsersEndPoint,
    required this.getOrdersEndPoint,
    required this.getProductsEndPoint,
    required this.getCategoriesEndPoint,
    required this.suspendProductEndPoint,
    required this.getOrderDetailsEndPoint,
  });

  final String getUsersEndPoint;
  final String getOrdersEndPoint;
  final String getProductsEndPoint;
  final String getCategoriesEndPoint;
  final String suspendProductEndPoint;
  final String getOrderDetailsEndPoint;

  factory Endpoints.fromJson(Map<String, dynamic> json) {
    return Endpoints(
      getUsersEndPoint: json[_AttributesKeys.loginEndPoint],
      getOrdersEndPoint: json[_AttributesKeys.getOrdersEndPoint],
      getProductsEndPoint: json[_AttributesKeys.getProductsEndpoint],
      getCategoriesEndPoint: json[_AttributesKeys.getCategoriesEndPoint],
      suspendProductEndPoint: json[_AttributesKeys.suspendProductEndPoint],
      getOrderDetailsEndPoint: json[_AttributesKeys.getOrderDetailsEndPoint],
    );
  }
}

abstract class _AttributesKeys {
  static const String loginEndPoint = 'getUsersEndPoint';
  static const String getOrdersEndPoint = 'getOrdersEndPoint';
  static const String getProductsEndpoint = 'getProductsEndPoint';
  static const String getCategoriesEndPoint = 'getCategoriesEndPoint';
  static const String suspendProductEndPoint = 'suspendProductEndPoint';
  static const String getOrderDetailsEndPoint = 'getOrderDetailsEndPoint';
}
