import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socially/domain/model/post.dart';

import '../domain/model/comment.dart';
import '../domain/model/story.dart';

class Repository {
  Repository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  Future<List<Post>> getPosts() async {
    final postsStore = _firestore.collection('posts');

    final snapshot = await postsStore
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: Post.fromFirebase,
          toFirestore: Post.toFirebase,
        )
        .get();

    final posts = snapshot.docs.map((e) {
      return e.data();
    }).toList();

    return posts;
  }

  Future<List<Story>> getStories() async {
    final storiesStore = _firestore.collection('stories');

    final snapshot = await storiesStore
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: Story.fromFirebase,
          toFirestore: Story.toFirebase,
        )
        .get();

    final stories = snapshot.docs.map((e) {
      return e.data();
    }).toList();

    return stories;
  }

  Future<Post> getPost(String postId) async {
    final postDoc = _firestore.collection('posts').doc(postId);

    final snapshot = await postDoc
        .withConverter(
          fromFirestore: Post.fromFirebase,
          toFirestore: Post.toFirebase,
        )
        .get();

    return snapshot.data()!;
  }

  Future<List<Comment>> getComments(String postId) async {
    final commentsCollection =
        _firestore.collection('posts').doc(postId).collection('comments');

    final snapshot = await commentsCollection
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: Comment.fromFirebase,
          toFirestore: Comment.toFirebase,
        )
        .get();

    final comments = snapshot.docs.map((e) {
      return e.data();
    }).toList();

    return comments;
  }
}
