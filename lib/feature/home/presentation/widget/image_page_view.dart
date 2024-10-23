import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socially/app/widget/no_overscroll_physics.dart';

/// A [PageView] of images
///
/// This also includes a dynamic scroll indicator
class ImagePageView extends StatefulWidget {
  const ImagePageView({
    super.key,
    required this.images,
    this.onImageTap,
  });

  final List<String> images;
  final Function(String)? onImageTap;

  @override
  State<ImagePageView> createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ScrollConfiguration(
              behavior: NoOverscrollBehavior(),
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    currentImage = page;
                  });
                },
                children: [
                  for (var image in widget.images)
                    CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 24,
            right: 8,
            left: 8,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: currentImage == i
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
