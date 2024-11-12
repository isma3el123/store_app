class BunnerModels {
  final int? id;
  final String? url;

  BunnerModels({
    required this.id,
    required this.url,
  });
  factory BunnerModels.fromJson({data}) {
    return BunnerModels(
      id: data['id'],
      url: data['image'],
    );
  }
}
