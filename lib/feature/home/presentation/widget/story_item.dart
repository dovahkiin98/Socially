import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socially/domain/model/story.dart';

/// A single Story item. Contains the Avatar of the user
class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.story,
    this.onTap,
  });

  final Story story;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: onTap,
      child: SizedBox.square(
        dimension: 76,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            clipBehavior: Clip.hardEdge,
            child: StreamBuilder(
              stream: story.user.snapshots(),
              builder: (context, snapshot) {
                final user = snapshot.data?.data();

                return DecoratedBox(
                  decoration: BoxDecoration(
                    image: user != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(user.image),
                          )
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
