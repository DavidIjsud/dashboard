class Category {
  String? id;
  String? name;
  bool? isDeleted;

  Category({this.id, this.name, this.isDeleted});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['categoryName'];
    isDeleted = json['isDeleted'] ?? false;
  }
}
