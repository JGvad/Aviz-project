class SubCategoryModel {
  final String name;
  final String id;
  final String category;
  SubCategoryModel(
      {required this.name, required this.category, required this.id});

  factory SubCategoryModel.fromJson(Map<String, dynamic> jsonMapObject) {
    return SubCategoryModel(
      id: jsonMapObject['id'],
      name: jsonMapObject['name'],
      category: jsonMapObject['category'],
    );
  }
}
