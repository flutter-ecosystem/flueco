import 'package:flutter/widgets.dart';

class AdaptativeSizedBox extends StatelessWidget {
  const AdaptativeSizedBox({
    super.key,
    this.width = const AdaptativeSize.biggest(),
    this.height = const AdaptativeSize.biggest(),
    this.child,
  });

  final AdaptativeSize width;
  final AdaptativeSize height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final effectiveWidth = width.effectiveSize(screenWidth);
    final effectiveHeight = height.effectiveSize(screenHeight);
    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: child,
    );
  }
}

/// Class to define the adaptative size factor for the different screen sizes.
///
/// The size factor is a value between 1 and 16 that defines the size of the dialog relative to the screen size.
/// For example, if the size factor is 4, the dialog will take 4/16 of the screen size.
/// If the size factor is 8, the dialog will take 8/16 of the screen size.
class AdaptativeSize {
  static const int maxSizeFactor = 16;
  static const int minSizeFactor = 1;

  final int xxl;
  final int xl;
  final int lg;
  final int md;
  final int sm;
  final int xs;

  const AdaptativeSize({
    this.xxl = maxSizeFactor,
    this.xl = maxSizeFactor,
    this.lg = maxSizeFactor,
    this.md = maxSizeFactor,
    this.sm = maxSizeFactor,
    this.xs = maxSizeFactor,
  });

  const AdaptativeSize.all(int size)
      : this(xxl: size, xl: size, lg: size, md: size, sm: size, xs: size);

  const AdaptativeSize.only({
    int? xxl,
    int? xl,
    int? lg,
    int? md,
    int? sm,
    int? xs,
    int defaultSize = maxSizeFactor,
  }) : this(
            xxl: xxl ?? defaultSize,
            xl: xl ?? defaultSize,
            lg: lg ?? defaultSize,
            md: md ?? defaultSize,
            sm: sm ?? defaultSize,
            xs: xs ?? defaultSize);

  const AdaptativeSize.xs(int sizeFactor)
      : this(
            xxl: maxSizeFactor,
            xl: maxSizeFactor,
            lg: maxSizeFactor,
            md: maxSizeFactor,
            sm: maxSizeFactor,
            xs: sizeFactor);

  const AdaptativeSize.sm(int sizeFactor)
      : this(
            xxl: sizeFactor,
            xl: sizeFactor,
            lg: sizeFactor,
            md: sizeFactor,
            sm: sizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.md(int sizeFactor)
      : this(
            xxl: sizeFactor,
            xl: sizeFactor,
            lg: sizeFactor,
            md: sizeFactor,
            sm: maxSizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.lg(int sizeFactor)
      : this(
            xxl: sizeFactor,
            xl: sizeFactor,
            lg: sizeFactor,
            md: maxSizeFactor,
            sm: maxSizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.xl(int sizeFactor)
      : this(
            xxl: sizeFactor,
            xl: sizeFactor,
            lg: maxSizeFactor,
            md: maxSizeFactor,
            sm: maxSizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.xxl(int sizeFactor)
      : this(
            xxl: sizeFactor,
            xl: maxSizeFactor,
            lg: maxSizeFactor,
            md: maxSizeFactor,
            sm: maxSizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.biggest()
      : this(
            xxl: maxSizeFactor,
            xl: maxSizeFactor,
            lg: maxSizeFactor,
            md: maxSizeFactor,
            sm: maxSizeFactor,
            xs: maxSizeFactor);

  const AdaptativeSize.smallest()
      : this(
            xxl: minSizeFactor,
            xl: minSizeFactor,
            lg: minSizeFactor,
            md: minSizeFactor,
            sm: minSizeFactor,
            xs: minSizeFactor);

  double effectiveSize(double size) {
    var factor = xs;
    if (size >= 1600) {
      factor = xxl;
    } else if (size >= 1200) {
      factor = xl;
    } else if (size >= 992) {
      factor = lg;
    } else if (size >= 768) {
      factor = md;
    } else if (size >= 576) {
      factor = sm;
    }
    return factor * size / maxSizeFactor;
  }

  AdaptativeSize and({
    int? xxl,
    int? xl,
    int? lg,
    int? md,
    int? sm,
    int? xs,
  }) {
    return AdaptativeSize(
      xxl: xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? this.xxl,
      xl: xl ?? lg ?? md ?? sm ?? xs ?? this.xl,
      lg: lg ?? md ?? sm ?? xs ?? this.lg,
      md: md ?? sm ?? xs ?? this.md,
      sm: sm ?? xs ?? this.sm,
      xs: xs ?? this.xs,
    );
  }
}
