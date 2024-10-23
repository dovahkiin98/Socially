import 'package:flutter/widgets.dart';

/// A [ScrollBehavior] that does not have any Overscroll Indicator
class NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
