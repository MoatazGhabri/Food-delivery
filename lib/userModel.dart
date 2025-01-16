class UserModel {
  late String uid;
  late String name;
  late String email;
  late String number;
  late String address;

  UserModel({
    required this.uid,
    required this.number,
    required this.email,
    required this.name,
    required this.address,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      number: map['number'],
    );
  }
}