/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/Angrboda.jpg
  AssetGenImage get angrboda => const AssetGenImage('assets/jpg/Angrboda.jpg');

  /// File path: assets/jpg/Atreus.jpg
  AssetGenImage get atreus => const AssetGenImage('assets/jpg/Atreus.jpg');

  /// File path: assets/jpg/Freya.jpg
  AssetGenImage get freya => const AssetGenImage('assets/jpg/Freya.jpg');

  /// File path: assets/jpg/Kratos.jpg
  AssetGenImage get kratos => const AssetGenImage('assets/jpg/Kratos.jpg');

  /// File path: assets/jpg/Odin.jpg
  AssetGenImage get odin => const AssetGenImage('assets/jpg/Odin.jpg');

  /// File path: assets/jpg/Thor.jpg
  AssetGenImage get thor => const AssetGenImage('assets/jpg/Thor.jpg');

  /// File path: assets/jpg/Tyr.jpg
  AssetGenImage get tyr => const AssetGenImage('assets/jpg/Tyr.jpg');

  /// File path: assets/jpg/test_story.jpg
  AssetGenImage get testStory =>
      const AssetGenImage('assets/jpg/test_story.jpg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [angrboda, atreus, freya, kratos, odin, thor, tyr, testStory];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/back.svg
  SvgGenImage get back => const SvgGenImage('assets/svg/back.svg');

  /// File path: assets/svg/bell.svg
  SvgGenImage get bell => const SvgGenImage('assets/svg/bell.svg');

  /// File path: assets/svg/bookmark.svg
  SvgGenImage get bookmark => const SvgGenImage('assets/svg/bookmark.svg');

  /// File path: assets/svg/comment.svg
  SvgGenImage get comment => const SvgGenImage('assets/svg/comment.svg');

  /// File path: assets/svg/download.svg
  SvgGenImage get download => const SvgGenImage('assets/svg/download.svg');

  /// File path: assets/svg/explore.svg
  SvgGenImage get explore => const SvgGenImage('assets/svg/explore.svg');

  /// File path: assets/svg/heart_empty.svg
  SvgGenImage get heartEmpty => const SvgGenImage('assets/svg/heart_empty.svg');

  /// File path: assets/svg/home.svg
  SvgGenImage get home => const SvgGenImage('assets/svg/home.svg');

  /// File path: assets/svg/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/svg/logo.svg');

  /// File path: assets/svg/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/svg/profile.svg');

  /// File path: assets/svg/tag.svg
  SvgGenImage get tag => const SvgGenImage('assets/svg/tag.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        back,
        bell,
        bookmark,
        comment,
        download,
        explore,
        heartEmpty,
        home,
        logo,
        profile,
        tag
      ];
}

class Assets {
  Assets._();

  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
