import 'package:flutter/material.dart';
import 'package:socially/app/theme/colors.dart';
import 'package:socially/gen/assets.gen.dart';

/// Custom back button that is filled instead of just an IconButton
class FilledBackButton extends StatelessWidget {
  const FilledBackButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white.withOpacity(0.7),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        splashColor: AppColors.primary,
        onTap: () {
          if (onTap == null) {
            Navigator.of(context).maybePop();
          } else {
            onTap!();
          }
        },
        child: Assets.svg.back.svg(
          height: 24,
          width: 24,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
