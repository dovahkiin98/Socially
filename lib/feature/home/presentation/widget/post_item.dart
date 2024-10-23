import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socially/app/theme/colors.dart';
import 'package:socially/app/widget/markdown_text.dart';
import 'package:socially/domain/model/post.dart';
import 'package:socially/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'image_grid.dart';
import 'image_page_view.dart';
import 'post_tags_row.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final Post post;

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
            bottom: 8,
          ),
          child: Column(
            children: [
              // User name and avatar, and post time-ago
              _PostTopBar(
                post: post,
              ),
              if (post.images.length <= 4 && post.images.isNotEmpty) ...[
                SizedBox(height: 8),
                StaggeredImageGrid(
                  images: post.images,
                ),
              ],
              if (post.images.length > 4) ...[
                SizedBox(height: 8),
                ImagePageView(
                  images: post.images,
                ),
              ],
              // No need to draw the text or it's leading space if there is no text
              if (post.text.isNotEmpty) ...[
                SizedBox(height: 8),
                MarkdownText(
                  post.text,
                  padding: post.images.isNotEmpty
                      ? EdgeInsets.symmetric(
                          horizontal: 8,
                        )
                      : EdgeInsets.zero,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  boldStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
              if (post.tags.isNotEmpty) ...[
                SizedBox(height: 4),
                Padding(
                  padding: post.images.isNotEmpty
                      ? EdgeInsets.symmetric(
                          horizontal: 4,
                        )
                      : EdgeInsets.zero,
                  child: PostTagsRow(
                    tags: post.tags,
                  ),
                ),
              ],
              // If there are no images in the post, we add a divider between the text and the actions
              if (post.images.isEmpty) ...[
                SizedBox(height: 4),
                Divider(
                  color: AppColors.primaryContainer,
                  thickness: 1,
                ),
              ],
              // The actions
              _PostBottomBar(
                post: post,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostTopBar extends StatelessWidget {
  const _PostTopBar({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: post.user.snapshots(),
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
              timeago.format(post.createdAt.toDate()),
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

class _PostBottomBar extends StatelessWidget {
  const _PostBottomBar({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // We had to customize the Button style, as the default style contains too much padding and margin
        TextButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            foregroundColor: AppColors.onSurface,
            textStyle: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          label: Text('1,320'),
          icon: Assets.svg.heartEmpty.svg(
            colorFilter: ColorFilter.mode(
              AppColors.onSurface.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 4),
        TextButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            foregroundColor: AppColors.onSurface,
            textStyle: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          label: Text('23'),
          icon: Assets.svg.comment.svg(
            colorFilter: ColorFilter.mode(
              AppColors.onSurface.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 4),
        Spacer(),
        SizedBox(width: 4),
        IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 24,
          constraints: BoxConstraints.tight(Size.square(36)),
          onPressed: () {},
          icon: Assets.svg.bookmark.svg(
            colorFilter: ColorFilter.mode(
              AppColors.onSurface.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
