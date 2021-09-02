import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  late String id;
  late String name;
  late int age;
  late String profilePhotoPath;

  AppUser(
      {required this.id,
      required this.name,
      required this.age,
      required this.profilePhotoPath});

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    age = snapshot['age'];
    profilePhotoPath = snapshot['profile_photo_path'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profile_photo_path': profilePhotoPath,
    };
  }
}
