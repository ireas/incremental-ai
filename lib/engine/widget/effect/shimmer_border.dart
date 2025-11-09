import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reusable shimmer border overlay that wraps any widget and animates a glowing border around it.
class ShimmerBorder extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final Color colorShimmer;
  final bool enabled;
  final Duration duration;
  final Duration delay;

  /// Constructor.
  const ShimmerBorder({
    super.key,
    required this.child,
    required this.colorShimmer,
    this.enabled = true,
    this.borderWidth = 3.0,
    this.borderRadius = 4.0,
    this.duration = const Duration(milliseconds: 600),
    this.delay = const Duration(milliseconds: 2000),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough, // Ensures the border matches the child's size
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true, // Allow interaction with the underlying child
            child: enabled
                ? Animate(
                    onPlay: (controller) => controller.repeat(reverse: false),
                    effects: [
                      ShimmerEffect(
                        duration: duration,
                        delay: delay,
                        blendMode: BlendMode.srcIn,
                        colors: [Colors.transparent, colorShimmer, Colors.transparent],
                      ),
                    ],
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: borderWidth),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
      ],
    );
  }
}
