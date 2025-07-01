import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  String? id;
  String? name;
  num? price;
  String? image;
  String? description;
  int? totalInStock;
  bool? isSuspended;
  String? categoryId;
  String? categoryName;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.totalInStock,
    this.isSuspended,
    this.categoryId,
    this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['productName'],
      price: json['price'],
      image: json['image'],
      description: json['detailOfProduct'],
      totalInStock: json['totalInStock'],
      isSuspended: json['isSuspended'],
      categoryId: json['category']['id'],
      categoryName: json['category']['categoryName'],
    );
  }

  @override
  List<Object?> get props => [categoryName, id, name, price, image, description, totalInStock, isSuspended, categoryId];
}
