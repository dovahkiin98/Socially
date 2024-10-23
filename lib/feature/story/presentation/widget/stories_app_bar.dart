import 'package:flutter/material.dart';
import 'package:socially/app/widget/filled_back_button.dart';
import 'package:socially/domain/model/story.dart';
import 'package:socially/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Custom AppBar. This is used in Stories page as the appbar in the page is too different than the Material [AppBar]
class StoriesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoriesAppBar({
    super.key,
    required this.progress,
    required this.story,
    required this.visible,
    required this.count,
  });

  final double progress;
  final Story story;
  final bool visible;
  final int count;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: 200),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < count; i++) ...[
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress - i,
                    ),
                  ),
                  if (i < count - 1) SizedBox(width: 4),
                ],
              ],
            ),
            AppBar(
              leadingWidth: 72,
              leading: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: FilledBackButton(),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              title: StreamBuilder(
                stream: story.user.snapshots(),
                builder: (context, snapshot) {
                  final user = snapshot.data?.data();

                  if (user == null) {
                    return SizedBox();
                  }

                  return Row(
                    children: [
                      Flexible(
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        timeago.format(story.createdAt.toDate()),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 8,
                  ),
                  child: IconButton(
                    splashRadius: 24,
                    onPressed: () {},
                    icon: Assets.svg.download.svg(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
