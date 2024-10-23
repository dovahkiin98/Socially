import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart' as intl;

/// Use [MarkdownBody] to create a widget that only contains Text
///
/// This should not be used if the Markdown text contains more than Text
class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.text, {
    super.key,
    this.style,
    this.boldStyle,
    this.textAlign,
    this.padding = EdgeInsets.zero,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? boldStyle;
  final TextAlign? textAlign;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Directionality(
        textDirection: intl.Bidi.detectRtlDirectionality(text)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: MarkdownBody(
          data: text,
          shrinkWrap: true,
          fitContent: false,
          styleSheet: MarkdownStyleSheet(
            p: style,
            strong: boldStyle,
            textAlign: _textAlign(textAlign),
          ),
        ),
      ),
    );
  }

  WrapAlignment _textAlign(TextAlign? textAlign) => switch (textAlign) {
        TextAlign.center => WrapAlignment.center,
        TextAlign.start => WrapAlignment.start,
        TextAlign.end => WrapAlignment.end,
        TextAlign.right => WrapAlignment.end,
        TextAlign.left => WrapAlignment.start,
        _ => WrapAlignment.start,
      };
}
