import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/widget/theme/theme_colors.dart';
import 'package:incremental_ai/module/cutscene/widget/cutscene_overview.dart';

/// Layout root that splits the screen in the following regions, each must be filled with one child widget.
/// - Left: left region from top to bottom
/// - Header: top region next to Left, full screen width
/// - Main: center region next to Left, split horizontally into three more subregions
/// - Footer: bottom region next to Left, full screen width
///
/// The flex values can be optionally set to customize relative size of regions.
///
/// Should be used as root container for all visual widgets, can be wrapped with non-visual provider widgets.
class BaseLayout extends StatelessWidget {
  /*
   * CHILDREN
   */
  final Widget header;
  final Widget footer;
  final Widget left;
  final Widget mainLeft;
  final Widget mainRight;

  /// Constructor.
  const BaseLayout({
    required this.header,
    required this.footer,
    required this.left,
    required this.mainLeft,
    required this.mainRight,
  }) : super(key: const Key("root"));

  @override
  Widget build(BuildContext context) {
    // use safe area to avoid intrusions by the operating system
    return SafeArea(
      child: Stack(
        // stack takes up full window space
        fit: StackFit.expand,
        children: [
          // add dark background gradient for sutle styling
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.colors.backgroundDark,
                  context.colors.backgroundMedium,
                  context.colors.backgroundDark,
                  context.colors.backgroundMedium,
                  context.colors.backgroundDark,
                ],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
              ),
            ),
          ),

          // screen region layout
          Row(
            children: [
              Expanded(flex: 25, child: left),

              Expanded(
                flex: 75,
                child: Column(
                  children: [
                    Expanded(flex: 20, child: header),
                    Expanded(
                      flex: 70,
                      child: Row(
                        children: [
                          Expanded(flex: 50, child: mainLeft),
                          Expanded(flex: 50, child: mainRight),
                        ],
                      ),
                    ),
                    Expanded(flex: 10, child: footer),
                  ],
                ),
              ),
            ],
          ),

          // overlay for cutscenes
          CutsceneOverview(),
        ],
      ),
    );
  }
}
