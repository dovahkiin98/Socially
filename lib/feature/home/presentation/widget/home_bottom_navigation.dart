import 'package:flutter/material.dart';
import 'package:socially/app/theme/colors.dart';
import 'package:socially/gen/assets.gen.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    // We use a Material, so in case we use a Container as a child, we don't miss out on the Ink response
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
        ),
      ),
      color: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(
              horizontal: 24,
            ) +
            EdgeInsets.only(
              bottom: padding.bottom + 8,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HomeBottomNavigationItem(
              selected: currentIndex == 0,
              onTap: () {
                onTap(0);
              },
              child: Assets.svg.home.svg(
                height: 26,
                width: 26,
              ),
            ),
            _HomeBottomNavigationItem(
              selected: currentIndex == 1,
              onTap: () {
                onTap(1);
              },
              child: Assets.svg.explore.svg(
                height: 26,
                width: 26,
              ),
            ),
            _HomeBottomNavigationItem(
              selected: currentIndex == 2,
              onTap: () {
                onTap(2);
              },
              child: Assets.svg.profile.svg(
                height: 26,
                width: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBottomNavigationItem extends StatelessWidget {
  const _HomeBottomNavigationItem({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        // ColorFiltered works no matter the child
        // use this to avoid making the child always an SVG or always an Icon
        child: ColorFiltered(
          colorFilter: selected
              ? ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                )
              : ColorFilter.mode(
                  AppColors.onSurface,
                  BlendMode.srcIn,
                ),
          child: child,
        ),
      ),
    );
  }
}
