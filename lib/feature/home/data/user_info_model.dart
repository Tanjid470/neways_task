class UserModel {
  final String name;
  final String email;
  final String gender;
  final String dob;
  final String image;
  final String position;

  UserModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.image,
    required this.position,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      gender: data['gender'] ?? '',
      dob: data['dob'] ?? '',
      image: data['image'] ?? '',
      position: data['position'] ?? '',
    );
  }
}
