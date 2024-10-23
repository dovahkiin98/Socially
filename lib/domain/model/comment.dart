import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Comment {
  const Comment({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.text,
  });

  final String id;
  final String text;
  final DocumentReference<User> user;
  final Timestamp createdAt;

  static Comment fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};

    return Comment(
      id: snapshot.id,
      user: (data['user'] as DocumentReference).withConverter(
        fromFirestore: User.fromFirebase,
        toFirestore: User.toFirebase,
      ),
      text: data['text'],
      createdAt: data['createdAt'],
    );
  }

  static Map<String, Object?> toFirebase(
    Comment value,
    SetOptions? options,
  ) {
    return {};
  }
}
