import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Post {
  const Post({
    required this.id,
    this.text = '',
    required this.user,
    required this.createdAt,
    this.images = const [],
    this.tags = const [],
  });

  final String id;
  final String text;
  final List<String> images;
  final List<String> tags;
  final DocumentReference<User> user;
  final Timestamp createdAt;

  static Post fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};

    return Post(
      id: snapshot.id,
      tags: List<String>.from(data['tags'] ?? []),
      user: (data['user'] as DocumentReference).withConverter(
        fromFirestore: User.fromFirebase,
        toFirestore: User.toFirebase,
      ),
      images: List<String>.from(data['images'] ?? []),
      text: data['text'] ?? '',
      createdAt: data['createdAt'],
    );
  }

  static Map<String, Object?> toFirebase(
    Post value,
    SetOptions? options,
  ) {
    return {};
  }
}
