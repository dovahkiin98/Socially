import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:socially/domain/model/post.dart';
import 'package:socially/domain/model/user.dart';
import 'package:socially/gen/assets.gen.dart';

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

    try {
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
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Story>> getStories() async {
    final storiesStore = _firestore.collection('stories');

    try {
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
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void fillDummyData() async {
    final usersStore = _firestore.collection('users');
    final postsStore = _firestore.collection('posts');

    final usersStorage = _storage.ref('users');
    final postsStorage = _storage.ref('posts');

    for (int i = 0; i < posts.length; i++) {
      final post = posts[i];
      final user = users[i];

      final userDoc = usersStore.doc();
      final avatarFile =
          await rootBundle.load((user['image'] as AssetGenImage).path);
      final avatarRef = usersStorage.child(userDoc.id).child('avatar.jpg');
      await avatarRef.putData(
        avatarFile.buffer.asUint8List(),
      );

      final avatarUrl = await avatarRef.getDownloadURL();

      await userDoc.set({
        'name': user['name'],
        'image': avatarUrl,
      });

      final postDoc = postsStore.doc();

      final postStorageRef = postsStorage.child(postDoc.id);
      final postImages = <String>[];

      for (var i = 0; i < (post['images'] as int? ?? 0); i++) {
        final image =
            await http.get(Uri.parse('https://picsum.photos/1000/1000'));

        final imageRef = postStorageRef.child('$i.jpg');
        await imageRef.putData(image.bodyBytes);

        final imageUrl = await imageRef.getDownloadURL();
        postImages.add(imageUrl);
      }

      await postDoc.set({
        'user': userDoc,
        'text': post['text'],
        'images': postImages,
        'tags': post['tags'],
        'createdAt': Timestamp.fromDate(post['date'] as DateTime),
      });
    }
  }

  void fillDummyStories() async {
    final usersStore = _firestore.collection('users');
    final storiesStore = _firestore.collection('stories');

    final storiesStorage = _storage.ref('stories');

    final users = await usersStore
        .withConverter(
          fromFirestore: User.fromFirebase,
          toFirestore: User.toFirebase,
        )
        .get();

    for (int i = 0; i < users.size; i++) {
      final user = users.docs[i];

      final storyDoc = storiesStore.doc();

      final storyStorageRef = storiesStorage.child(storyDoc.id);
      final storyImages = <String>[];

      for (var j = 0; j <= (i % 3); j++) {
        final image =
            await http.get(Uri.parse('https://picsum.photos/720/1280'));

        final imageRef = storyStorageRef.child('$i.jpg');
        await imageRef.putData(image.bodyBytes);

        final imageUrl = await imageRef.getDownloadURL();
        storyImages.add(imageUrl);
      }

      await storyDoc.set({
        'user': user.reference,
        'images': storyImages,
        'tags': posts[i]['tags'],
        'createdAt': Timestamp.fromDate(posts[i]['date'] as DateTime),
      });
    }
  }
}

final posts = [
  {
    'text':
        'Stopped by **@zoesugg** today with goosey girl to see **@kyliecosmetics** & **@kylieskin 💕** wow what a dream!!!!!!!! \nIt’s the best experience we have!',
    'date': DateTime.now(),
  },
  {
    'text':
        'This is one of the best experiences that I\'ve ever had in my life! The mountain view here is amazing',
    'images': 5,
    'tags': [
      'Alberta',
      'Cold',
      'Meditation',
      'Hello',
      'World',
    ],
    'date': DateTime.now().subtract(Duration(minutes: 10)),
  },
  {
    'text':
        'This is one of the best experiences that I\'ve ever had in my life! The mountain view here is amazing',
    'images': 1,
    'tags': [
      'Alberta',
    ],
    'date': DateTime.now().subtract(Duration(hours: 1)),
  },
  {
    'images': 1,
    'date': DateTime.now().subtract(Duration(days: 1)),
  },
  {
    'images': 2,
    'tags': [
      'Alberta',
      'Cold',
    ],
    'date': DateTime.now().subtract(Duration(days: 8)),
  },
  {
    'images': 3,
    'tags': [
      'Alberta',
      'Cold',
      'Meditation',
    ],
    'date': DateTime.now().subtract(Duration(days: 17)),
  },
  {
    'images': 5,
    'date': DateTime.now().subtract(Duration(days: 40)),
  },
];

final users = [
  {
    'name': 'Angrboda',
    'image': Assets.jpg.angrboda,
  },
  {
    'name': 'Atreus',
    'image': Assets.jpg.atreus,
  },
  {
    'name': 'Kratos',
    'image': Assets.jpg.kratos,
  },
  {
    'name': 'Thor',
    'image': Assets.jpg.thor,
  },
  {
    'name': 'Odin',
    'image': Assets.jpg.odin,
  },
  {
    'name': 'Tyr',
    'image': Assets.jpg.tyr,
  },
  {
    'name': 'Freya',
    'image': Assets.jpg.freya,
  },
];
