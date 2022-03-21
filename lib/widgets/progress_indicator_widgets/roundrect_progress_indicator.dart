// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:html';
// import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// const double _kMinCircularProgressIndicatorSize = 36.0;
const int _kIndeterminateLinearDuration = 1800;
// const int _kIndeterminateCircularDuration = 1333 * 2222;

// enum _ActivityIndicatorType { material, adaptive }

/// A base class for material design progress indicators.
///
/// This widget cannot be instantiated directly. For a linear progress
/// indicator, see [RoundRectIndicator]. For a circular progress indicator,
/// see [CircularProgressIndicator].
///
/// See also:
///
///  * <https://material.io/design/components/progress-indicators.html>
abstract class ProgressIndicator extends StatefulWidget {
  const ProgressIndicator({
    Key? key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
  }) : super(key: key);

  final double? value;

  /// The progress indicator's background color.
  ///
  /// The current theme's [ColorScheme.background] by default.
  ///
  /// This property is ignored if used in an adaptive constructor inside an iOS
  /// environment.
  final Color? backgroundColor;
  final Color? color;

  final Animation<Color?>? valueColor;

  final String? semanticsLabel;

  final String? semanticsValue;

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).colorScheme.background;
  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? color ?? Theme.of(context).colorScheme.primary;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value,
        showName: false, ifNull: '<indeterminate>'));
  }

  Widget _buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    String? expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  const _LinearProgressIndicatorPainter({
    required this.backgroundColor,
    required this.valueColor,
    this.value,
    required this.animationValue,
    required this.radius,
    required this.textDirection,
  }) : assert(textDirection != null);

  final Color backgroundColor;
  final Color valueColor;
  final double? value;
  final double animationValue;
  final double radius;
  final TextDirection textDirection;

  // The indeterminate progress animation displays two lines whose leading (head)
  // and trailing (tail) endpoints are defined by the following four curves.
  static const Curve line1Head = Interval(
    0.0,
    750.0 / _kIndeterminateLinearDuration,
    curve: Cubic(0.2, 0.0, 0.8, 1.0),
  );
  static const Curve line1Tail = Interval(
    333.0 / _kIndeterminateLinearDuration,
    (333.0 + 750.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static const Curve line2Head = Interval(
    1000.0 / _kIndeterminateLinearDuration,
    (1000.0 + 567.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.0, 0.0, 0.65, 1.0),
  );
  static const Curve line2Tail = Interval(
    1267.0 / _kIndeterminateLinearDuration,
    (1267.0 + 533.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.10, 0.0, 0.45, 1.0),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    // canvas.drawRect(Offset.zero & size, paint);
    // background roundrect
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
        paint);

    paint.color = valueColor;

    void drawBar(double x, double width) {
      if (width <= 0.0) return;

      final double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:

          /// popular side
          left = x;
          break;
      }

      value! <= 0.99 ? canvas.drawRRect(RRect.fromRectAndCorners(Offset(left, 0.0) & Size(width, size.height), topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius)), paint) : canvas.drawRRect(
          RRect.fromRectAndRadius(Offset(left, 0.0) & Size(width, size.height),
            Radius.circular(radius),),
          paint);

    }


    if (value != null) {
      // drawBar(lowerLimit, value!.clamp(0.0, 1.0) * size.width);
      drawBar(0.0, (value!.clamp(0.0, 1.0) * size.width));
    } else {
      final double x1 = size.width * line1Tail.transform(animationValue);
      final double width1 =
          size.width * line1Head.transform(animationValue) - x1;

      final double x2 = size.width * line2Tail.transform(animationValue);
      final double width2 =
          size.width * line2Head.transform(animationValue) - x2;

      drawBar(x1, width1);
      drawBar(x2, width2);
    }
  }

  @override
  bool shouldRepaint(_LinearProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.animationValue != animationValue ||
        oldPainter.textDirection != textDirection;
  }
}

///
///  * [CircularProgressIndicator], which shows progress along a circular arc.
///  * [RefreshIndicator], which automatically displays a [CircularProgressIndicator]
///    when the underlying vertical scrollable is overscrolled.
///  * <https://material.io/design/components/progress-indicators.html#linear-progress-indicators>
class RoundRectIndicator extends ProgressIndicator {
  /// Creates a linear progress indicator.
  ///
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  const RoundRectIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Color? color,
    Animation<Color?>? valueColor,
    this.radius,
    this.minHeight,
    String? semanticsLabel,
    String? semanticsValue,
  })  : assert(minHeight == null || minHeight > 0),
        super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  /// The minimum height of the line used to draw the indicator.
  ///
  /// This defaults to 4dp.
  final double? minHeight;
  final double? radius;

  @override
  _LinearProgressIndicatorState createState() =>
      _LinearProgressIndicatorState();
}

class _LinearProgressIndicatorState extends State<RoundRectIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(RoundRectIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double animationValue,
      TextDirection textDirection) {
    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: widget.minHeight ?? 4.0,
        ),
        child: CustomPaint(
          painter: _LinearProgressIndicatorPainter(
            radius: widget.radius!,
            backgroundColor: widget._getBackgroundColor(context),
            valueColor: widget._getValueColor(context),
            value: widget.value, // may be null
            animationValue:
                animationValue, // ignored if widget.value is not null
            textDirection: textDirection,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    if (widget.value != null)
      return _buildIndicator(context, _controller.value, textDirection);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(context, _controller.value, textDirection);
      },
    );
  }
}
