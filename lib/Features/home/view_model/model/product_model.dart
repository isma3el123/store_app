class ProuductModels {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;
  final String name;

  ProuductModels({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
  });

  factory ProuductModels.fromJson({required Map<String, dynamic> data}) {
    return ProuductModels(
      id: data['id'].toInt(),
      price: data['price'].toInt(),
      oldPrice: data['old_price'].toInt(),
      discount: data['discount'].toInt(),
      image: data['image'].toString(),
      name: data['name'].toString(),
    );
  }
}
