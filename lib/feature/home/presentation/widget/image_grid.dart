import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'image_page_view.dart';

/// A [StaggeredGrid] of images. Only to be used if the images are less than 5. Otherwise use the [ImagePageView]
///
/// This works like the following: (Repeated item means 2 rows)
/// - 1 image:
///
/// 1
/// - 2 images:
///
/// 1 2
///
/// 1 2
/// - 3 images :
/// 1 2
///
/// 1 3
///
/// - 4 images:
/// 1 2
///
/// 3 4
///
class StaggeredImageGrid extends StatelessWidget {
  const StaggeredImageGrid({
    super.key,
    required this.images,
    this.onImageTap,
  });

  final List<String> images;
  final Function(String)? onImageTap;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: images.length < 2 ? 2 : 1,
          mainAxisCellCount: images.length < 4 ? 2 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: images[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (images.length > 1)
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: images.length < 3 ? 2 : 1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: images[1],
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (images.length > 2)
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: images[2],
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (images.length > 3)
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: images[3],
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}
