class CategoriesModel {
  final int? id;
  final String? url;
  final String? name;

  CategoriesModel({
    required this.id,
    required this.url,
    required this.name,
  });
  factory CategoriesModel.fromJson({data}) {
    return CategoriesModel(
      id: data['id'],
      url: data['image'],
      name: data['name'],
    );
  }
}
