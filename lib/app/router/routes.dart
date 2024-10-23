import 'package:socially/domain/model/story.dart';

/// String abstractions of Routes.
abstract class AppRoute {
  static const home = '/';
  static const stories = '/stories';
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
