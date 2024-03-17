// coverage:ignore-file

// ignore_for_file: always_specify_types

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:vector_graphics/vector_graphics.dart';

import 'assets.gen.dart';

export 'assets.gen.dart';
// export 'fonts.gen.dart';

/// Extension to add load capabilities
extension LoadAssetGenImage on AssetGenImage {
  /// Load the image in memory
  Future<void> load() {
    debugPrint('Loading asset $path');

    return _loadImage(provider());
  }
}

///
Future<void> loadImageAssetsInMemory() async {
  //final assets = Assets.images.values;
  final List assets = [];
  for (final asset in assets) {
    if (asset is AssetGenImage) {
      try {
        await asset.load();
      } catch (e) {
        debugPrint('Error loading image on memory: $e');
      }
    }
  }
}

/// Extension to add return the vector SVG
// extension VectorSvgGenImage on SvgGenImage {
//   /// Vector version the svg
//   Widget vector({
//     WidgetBuilder? placeholderBuilder,
//     BoxFit fit = BoxFit.contain,
//     String? semanticsLabel,
//   }) {
//     return VectorGraphic(
//       loader: AssetBytesLoader('$path.vec'),
//       fit: fit,
//       semanticsLabel: semanticsLabel,
//       placeholderBuilder: placeholderBuilder ??
//           (BuildContext context) {
//             return LayoutBuilder(
//               builder: (_, BoxConstraints constraints) => SizedBox(
//                 height: constraints.maxWidth,
//                 width: constraints.maxWidth,
//               ),
//             );
//           },
//     );
//   }
// }

Future<void> _loadImage(ImageProvider provider) {
  final ImageConfiguration config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: PlatformDispatcher.instance.views.first.devicePixelRatio,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer<void>();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo image, bool sync) {
      debugPrint('Image ${image.debugLabel} finished loading');
      completer.complete();
      stream.removeListener(listener);
    },
    onError: (Object exception, StackTrace? stackTrace) {
      completer.complete();
      stream.removeListener(listener);
      FlutterError.reportError(
        FlutterErrorDetails(
          context: ErrorDescription('image failed to load'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ),
      );
    },
  );

  stream.addListener(listener);

  return completer.future;
}
