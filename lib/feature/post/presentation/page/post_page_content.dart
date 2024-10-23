import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/model/post.dart';
import 'package:socially/feature/home/presentation/widget/post_item.dart';
import 'package:socially/feature/post/presentation/widget/comments_list.dart';

import '../../bloc/comments/comments_bloc.dart';

class PostPageContent extends StatefulWidget {
  const PostPageContent({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostPageContent> createState() => _PostPageContentState();
}

class _PostPageContentState extends State<PostPageContent> {
  late final CommentsBloc commentsBloc;

  @override
  void initState() {
    super.initState();

    commentsBloc = context.read<CommentsBloc>();
    commentsBloc.add(CommentsGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final commentsState = context.watch<CommentsBloc>().state;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: PostItem(post: widget.post),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Comments',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (commentsState is CommentsSuccessState)
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: CommentsList(comments: commentsState.data),
          ),
        if (commentsState is CommentsErrorState)
          SliverFillRemaining(
            child: Center(
              child: Text(
                commentsState.error.message ?? commentsState.error.toString(),
              ),
            ),
          ),
        if (commentsState is CommentsLoadingState)
          SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: padding.bottom),
        ),
      ],
    );
  }
}
