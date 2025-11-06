import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/cutscene/ui/cutscene_overview.dart';
import 'package:incremental_ai/engine/ui/layout/layout_footer.dart';
import 'package:incremental_ai/engine/ui/layout/layout_header.dart';
import 'package:incremental_ai/engine/ui/layout/layout_main.dart';
import 'package:incremental_ai/engine/ui/theme/theme_colors.dart';

/// Layout root that splits the screen in the following regions, each must be filled with one child widget.
/// - Left: left region from top to bottom
/// - Header: top region next to Left, full screen width
/// - Main: center region next to Left, split horizontally into three more subregions
/// - Footer: bottom region next to Left, full screen width
///
/// The flex values can be optionally set to customize relative size of regions.
///
/// Should be used as root container for all visual widgets, can be wrapped with non-visual provider widgets.
///
/// TODO: consider moving this into a game module
/// TODO: consider adding global debug setting that colors each sub region in random color for clear layout
class BaseLayout extends StatelessWidget {
  // CHILDREN
  final Widget header;
  final Widget footer;
  final Widget left;
  final Widget mainLeft;
  final Widget mainRight;

  // FLEX
  final int flexHeader;
  final int flexLeft;
  final int flexMain;
  final int flexFooter;

  /// Constructor.
  const BaseLayout({
    required this.header,
    required this.footer,
    required this.left,
    required this.mainLeft,
    required this.mainRight,
    this.flexHeader = 15,
    this.flexLeft = 25,
    this.flexMain = 75,
    this.flexFooter = 10,
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
              Expanded(flex: flexLeft, child: left),

              Expanded(
                flex: 100 - flexLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: flexHeader,
                      child: LayoutHeader(child: header),
                    ),
                    Expanded(
                      flex: flexMain,
                      child: LayoutMain(leftChild: mainLeft, rightChild: mainRight),
                    ),
                    Expanded(
                      flex: flexFooter,
                      child: LayoutFooter(child: footer),
                    ),
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
