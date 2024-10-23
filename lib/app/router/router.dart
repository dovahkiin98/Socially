import 'package:go_router/go_router.dart';
import 'package:socially/feature/home/presentation/page/home_page.dart';
import 'package:socially/feature/story/presentation/page/stories_page.dart';

final router = GoRouter(
  routes: [
    HomePage.route,
    StoriesPage.route,
  ],
);
