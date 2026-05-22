class CategoryModel {
  final String id;
  final String name;
  final String image;
  final int level;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.level,
  });

  factory CategoryModel.fromJson(
      Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      level: json['level'] ?? 0,
    );
  }
}