import 'package:petshopdashboard/core/enums.dart';

class OrderDetail {
  int quantity;
  String id;
  Product product;
  Order order;

  OrderDetail({required this.quantity, required this.id, required this.product, required this.order});

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    quantity: json["quantity"],
    id: json["\u0024id"],
    product: Product.fromJson(json["product"]),
    order: Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "\u0024id": id,
    "product": product.toJson(),
    "order": order.toJson(),
  };
}

class Order {
  OrderStatus status;
  int totalAmount;
  int discountAmount;
  int taxAmount;
  int shippingCost;
  PaymentStatus paymentStatus;
  PaymentMethod paymentMethod;
  bool isOrderDeleted;

  Order({
    required this.status,
    required this.totalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.shippingCost,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.isOrderDeleted,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    status: OrderStatus.fromString(json["status"]),
    totalAmount: json["totalAmount"],
    discountAmount: json["discountAmount"],
    taxAmount: json["taxAmount"],
    shippingCost: json["shippingCost"],
    paymentStatus: PaymentStatus.fromString(json["paymentStatus"]),
    paymentMethod: PaymentMethod.fromString(json["paymentMethod"]),
    isOrderDeleted: json["isOrderDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalAmount": totalAmount,
    "discountAmount": discountAmount,
    "taxAmount": taxAmount,
    "shippingCost": shippingCost,
    "paymentStatus": paymentStatus,
    "paymentMethod": paymentMethod,
    "isOrderDeleted": isOrderDeleted,
  };
}

class Product {
  String productName;
  String detailOfProduct;
  String image;
  bool isSuspended;
  String id;
  CategoryOrderDetail category;

  Product({
    required this.productName,
    required this.detailOfProduct,
    required this.image,
    required this.isSuspended,
    required this.id,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productName: json["productName"],
    detailOfProduct: json["detailOfProduct"],
    image: json["image"],
    isSuspended: json["isSuspended"],
    id: json["\u0024id"],
    category: CategoryOrderDetail.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "detailOfProduct": detailOfProduct,
    "image": image,
    "isSuspended": isSuspended,
    "\u0024id": id,
    "category": category.toJson(),
  };
}

class CategoryOrderDetail {
  String categoryName;
  String id;

  CategoryOrderDetail({required this.categoryName, required this.id});

  factory CategoryOrderDetail.fromJson(Map<String, dynamic> json) =>
      CategoryOrderDetail(categoryName: json["categoryName"], id: json["\u0024id"]);

  Map<String, dynamic> toJson() => {"categoryName": categoryName, "\u0024id": id};
}
