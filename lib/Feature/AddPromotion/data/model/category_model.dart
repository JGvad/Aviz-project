class CategoryModel {
  final String id;
  final String name;
  CategoryModel({required this.name, required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> jsonMapObject) {
    return CategoryModel(
      name: jsonMapObject['name'],
      id: jsonMapObject['id'],
    );
  }
}
