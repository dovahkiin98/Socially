import 'package:flutter/material.dart';
import 'package:socially/domain/model/comment.dart';

import 'comment_item.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.comments,
  });

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: comments.length,
      itemBuilder: (context, i) {
        final comment = comments[i];

        return CommentItem(
          comment: comment,
        );
      },
      separatorBuilder: (context, i) => SizedBox(height: 8),
    );
  }
}
