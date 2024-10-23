import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socially/app/theme/colors.dart';
import 'package:socially/app/widget/markdown_text.dart';
import 'package:socially/domain/model/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 12,
            start: 12,
            end: 12,
            bottom: 12,
          ),
          child: Column(
            children: [
              _CommentTopBar(
                comment: comment,
              ),
              MarkdownText(
                comment.text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                boldStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentTopBar extends StatelessWidget {
  const _CommentTopBar({
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: comment.user.snapshots(),
      builder: (context, snapshot) {
        final user = snapshot.data?.data();

        return Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage:
                  user != null ? CachedNetworkImageProvider(user.image) : null,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                user?.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              timeago.format(comment.createdAt.toDate()),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryContainer,
                fontSize: 14,
              ),
            ),
          ],
        );
      },
    );
  }
}
