import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Story {
  const Story({
    required this.id,
    required this.user,
    required this.createdAt,
    this.images = const [],
    this.tags = const [],
  });

  final String id;
  final List<String> images;
  final List<String> tags;
  final DocumentReference<User> user;
  final Timestamp createdAt;

  static Story fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};

    return Story(
      id: snapshot.id,
      tags: List<String>.from(data['tags'] ?? []),
      user: (data['user'] as DocumentReference).withConverter(
        fromFirestore: User.fromFirebase,
        toFirestore: User.toFirebase,
      ),
      images: List<String>.from(data['images'] ?? []),
      createdAt: data['createdAt'],
    );
  }

  static Map<String, Object?> toFirebase(
    Story value,
    SetOptions? options,
  ) {
    return {};
  }
}
