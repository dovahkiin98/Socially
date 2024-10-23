import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socially/gen/assets.gen.dart';

/// The overlay used in the Stories page.
///
/// This has a [visible] parameter to animate it between hidden and shown (when user taps)
class StoryOverlay extends StatelessWidget {
  const StoryOverlay({
    super.key,
    required this.visible,
  });

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: 200),
      child: Stack(
        children: [
          Positioned(
            height: 300 + padding.top,
            top: 0,
            right: 0,
            left: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  transform: GradientRotation(pi / 2),
                ),
              ),
            ),
          ),
          Positioned(
            height: 240 + padding.bottom,
            bottom: 0,
            right: 0,
            left: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  transform: GradientRotation(-pi / 2),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16 + padding.bottom,
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                onPressed: () {},
                icon: Assets.svg.heartEmpty.svg(
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
