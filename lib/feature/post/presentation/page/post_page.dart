import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/app/router/routes.dart';
import 'package:socially/gen/assets.gen.dart';

import '../../bloc/comments/comments_bloc.dart';
import '../../bloc/post/post_bloc.dart';
import 'post_page_content.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    super.key,
  });

  static final route = GoRoute(
    path: AppRoute.post,
    builder: (context, state) {
      final postId = state.pathParameters['id']!;

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PostBloc(
              repository: context.read(),
              postId: postId,
            )..add(PostGetDataEvent()),
          ),
          BlocProvider(
            create: (_) => CommentsBloc(
              repository: context.read(),
              postId: postId,
            ),
          ),
        ],
        child: PostPage(
          key: state.pageKey,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 76,
        title: Assets.svg.logo.svg(
          height: 24,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: context.read(),
        builder: (context, state) {
          if (state is PostSuccessState) {
            return PostPageContent(
              post: state.data,
            );
          }

          if (state is PostErrorState) {
            return Text(state.error.message ?? state.error.toString());
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
