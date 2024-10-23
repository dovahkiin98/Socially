import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/app/router/routes.dart';
import 'package:socially/domain/model/story.dart';

import '../widget/stories_app_bar.dart';
import '../widget/story_overlay.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({
    super.key,
    required this.story,
  });

  final Story story;

  static final route = GoRoute(
    path: AppRoute.stories,
    builder: (context, state) {
      final args = state.extra as StoriesArgs;

      return StoriesPage(
        key: state.pageKey,
        story: args.story,
      );
    },
  );

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController progressAnimation;

  bool showOverlay = true;
  final pageController = PageController();
  int currentIndex = 0;

  List<String> get images => widget.story.images;

  DateTime? tapDownTime;

  @override
  void initState() {
    super.initState();

    progressAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addListener(() {
        // Set state on every frame
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          nextImage();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: StoriesAppBar(
        count: images.length,
        progress: progressAnimation.value + currentIndex,
        visible: showOverlay,
        story: widget.story,
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onPanStart: (_) {
          tapDownTime = DateTime.now();

          progressAnimation.stop();

          Future.delayed(Duration(milliseconds: 200)).then((_) {
            if (tapDownTime != null) {
              setState(() {
                showOverlay = false;
              });
            }
          });
        },
        onPanEnd: (_) {
          if (tapDownTime != null &&
              DateTime.now().difference(tapDownTime!).inMilliseconds < 200) {
            nextImage();
          }

          setState(() {
            showOverlay = true;
          });

          tapDownTime = null;
          // We do not need to resume the animation, as the `imageBuilder` inside `CachedNetworkImage` runs on every frame, and will continue the animation
          // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ...images.mapIndexed((i, e) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: padding.top,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: e,
                      imageBuilder: (context, provider) {
                        // If we are not animation, or if the overflow is shown, forward the animation
                        // This works on every frame, meaning we don't need to resume the animation after pausing it
                        if (!progressAnimation.isAnimating &&
                            showOverlay &&
                            currentIndex == i) {
                          progressAnimation.forward();
                        }

                        return Image(
                          image: provider,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                })
              ],
            ),
            StoryOverlay(
              visible: showOverlay,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    progressAnimation.dispose();
    pageController.dispose();

    // Return the the default SystemUiMode before leaving the page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  void nextImage() {
    // If this is the last story, close the page
    if (currentIndex == images.length - 1) {
      Navigator.of(context).pop();
    }
    // Otherwise, scroll into the next story
    else {
      currentIndex++;

      progressAnimation.reset();
      pageController.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }
}
