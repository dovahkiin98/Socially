import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.image,
  });

  final String id;
  final String name;
  final String image;

  static User fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};

    return User(
      id: snapshot.id,
      name: data['name'],
      image: data['image'],
    );
  }

  static Map<String, Object?> toFirebase(
    User value,
    SetOptions? options,
  ) {
    return {};
  }
}
