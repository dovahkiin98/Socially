import 'package:flutter/material.dart';
import 'package:socially/domain/model/post.dart';

import '../widget/post_item.dart';
import '../widget/stories_bar.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final posts = widget.posts;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
      },
      child: ListView.separated(
        itemCount: posts.length + 1,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
              horizontal: 12,
            ) +
            EdgeInsets.only(
              bottom: padding.bottom + 16,
            ),
        itemBuilder: (context, i) {
          // The first item of this ListView is the StoriesBar
          if (i == 0) {
            return StoriesBar();
          } else {
            final post = posts[i - 1];

            return PostItem(
              key: ValueKey(post.id),
              post: post,
            );
          }
        },
        separatorBuilder: (context, i) => const SizedBox(height: 12),
      ),
    );
  }
}
