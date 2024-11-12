class UserModel {
  int id;
  String name;
  String email;
  String phone;
  String image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory UserModel.fromJson({required Map<String, dynamic> data}) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      image: data['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
