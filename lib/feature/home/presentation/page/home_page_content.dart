import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/app/router/routes.dart';
import 'package:socially/domain/model/post.dart';
import 'package:socially/feature/home/bloc/posts/posts_bloc.dart';

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
        final bloc = context.read<PostsBloc>();

        bloc.add(PostsGetDataEvent());
        await bloc.stream.first;
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

            return GestureDetector(
              onTap: () {
                context.push(AppRoute.postId(post.id));
              },
              child: PostItem(
                key: ValueKey(post.id),
                post: post,
              ),
            );
          }
        },
        separatorBuilder: (context, i) => const SizedBox(height: 12),
      ),
    );
  }
}
