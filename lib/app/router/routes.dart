import 'package:socially/domain/model/story.dart';

/// String abstractions of Routes.
abstract class AppRoute {
  static const home = '/';

  static const _post = '/post';
  static const post = '/post/:id';

  static const stories = '/stories';

  static String postId(String postId) {
    return '$_post/$postId';
  }
}

class StoriesArgs {
  StoriesArgs({
    required this.story,
    required this.startIndex,
  });

  final Story story;

  /// The index to start the stories in
  final int startIndex;
}
