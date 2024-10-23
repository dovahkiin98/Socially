import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:socially/domain/utils/string_ex.dart';
import 'package:socially/gen/assets.gen.dart';

class PostTagsRow extends StatelessWidget {
  const PostTagsRow({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    return Container(
      height: MediaQuery.textScalerOf(context).scale(48),
      alignment: Alignment.centerLeft,
      child: CustomBoxy(
        delegate: _PostTagsRowDelegate(
          tags: tags,
          textDirection: textDirection,
        ),
      ),
    );
  }
}

class _PostTagsRowDelegate extends BoxyDelegate {
  _PostTagsRowDelegate({
    required this.tags,
    required this.textDirection,
  });

  final TextDirection textDirection;
  final List<String> tags;

  @override
  Size layout() {
    Size size = Size.zero;

    BoxyChild surplusTag = inflate(_TagChip('+99'));
    final surplusSize = surplusTag.layout(constraints);

    for (int i = 0; i < tags.length; i++) {
      final child = inflate(_TagChip(tags[i]));

      final childSize = child.layout(constraints);
      final newSize = Size(
        size.width + childSize.width,
        size.height + childSize.height,
      );

      if (newSize.width + surplusSize.width > constraints.maxWidth) {
        child.ignore();

        surplusTag.ignore();
        surplusTag = inflate(_TagChip('+${tags.length - i}'));
        surplusTag.layout(constraints);
        surplusTag.position(Offset(
          size.width,
          0,
        ));

        return size;
      }

      child.positionOnAxis(
        size.width,
        0,
      );

      size = newSize;
    }

    surplusTag.ignore();

    return size;
  }

  @override
  bool shouldRelayout(covariant _PostTagsRowDelegate oldDelegate) {
    return textDirection != oldDelegate.textDirection ||
        tags != oldDelegate.tags;
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: Chip(
        avatar: Assets.svg.tag.svg(
          width: 14,
          height: 14,
        ),
        labelPadding: EdgeInsetsDirectional.only(
          start: 4,
          end: 10,
        ),
        label: Text(
          value.truncate(10),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
