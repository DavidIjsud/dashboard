import 'package:petshopdashboard/core/enums.dart';

class OrderModel {
  String id;
  OrderStatus status;
  int taxAmount;
  int shippingCost;
  PaymentStatus paymentStatus;
  PaymentMethod paymentMethod;
  int totalPayment;
  List<Product> products;
  User user;
  bool isOrderDeleted;
  Address? address;

  OrderModel({
    required this.id,
    required this.status,
    required this.taxAmount,
    required this.shippingCost,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.totalPayment,
    required this.products,
    required this.user,
    required this.isOrderDeleted,
    this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    status: OrderStatus.fromString(json["status"]),
    taxAmount: json["taxAmount"],
    shippingCost: json["shippingCost"],
    paymentStatus: PaymentStatus.fromString(json["paymentStatus"]),
    paymentMethod: PaymentMethod.fromString(json["paymentMethod"]),
    totalPayment: json["totalPayment"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    user: User.fromJson(json["user"]),
    isOrderDeleted: json["isOrderDeleted"],
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
  );

  String getOrderStatusText() {
    return OrderStatus.orderStatusText(status);
  }

  String getPaymentMethodText() {
    return PaymentMethod.paymentMethodText(paymentMethod);
  }

  String getPaymentStatusText() {
    return PaymentStatus.paymentStatusText(paymentStatus);
  }
}

class Product {
  int quantity;
  double totalPayment;
  String productId;
  String productName;

  Product({required this.quantity, required this.totalPayment, required this.productId, required this.productName});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    quantity: json["quantity"],
    totalPayment: json["totalPayment"]?.toDouble(),
    productId: json["productId"],
    productName: json["productName"] ?? '',
  );

  Map<String, dynamic> toJson() => {"quantity": quantity, "totalPayment": totalPayment, "productId": productId};
}

class User {
  String id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(id: json["id"], name: json["name"], email: json["email"]);
}

class Address {
  double latituded;
  double longitude;
  String street;
  String city;
  String deparment;
  String country;

  Address({
    required this.latituded,
    required this.longitude,
    required this.street,
    required this.city,
    required this.deparment,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    latituded: json["latituded"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    street: json["street"],
    city: json["city"],
    deparment: json["deparment"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "latituded": latituded,
    "longitude": longitude,
    "street": street,
    "city": city,
    "deparment": deparment,
    "country": country,
  };
}
