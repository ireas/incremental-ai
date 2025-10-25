import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:incremental_ai/engine/ui/layout/layout_footer.dart';
import 'package:incremental_ai/engine/ui/layout/layout_header.dart';
import 'package:incremental_ai/engine/ui/layout/layout_main.dart';

/// Layout root that splits the screen in the following regions, each must be filled with one child widget.
/// - Header: top region, full screen width
/// - Main: center region, split horizontally into three more subregions
/// - Footer: bottom region, full screen width
///
/// The flex values can be optionally set to customize relative size of regions.
///
/// Should be used as root container for all visual widgets, can be wrapped with non-visual provider widgets.
///
/// TODO: consider adding global debug setting that colors each sub region in random color for clear layout
class Layout extends StatelessWidget {
  // CHILDREN
  final Widget headerChild;
  final Widget footerChild;
  final Widget mainLeftChild;
  final Widget mainCenterChild;
  final Widget mainRightChild;

  // FLEX
  final int flexHeader;
  final int flexMain;
  final int flexFooter;

  /// Constructor.
  const Layout({
    required this.headerChild,
    required this.footerChild,
    required this.mainLeftChild,
    required this.mainCenterChild,
    required this.mainRightChild,
    this.flexHeader = 15,
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
          // add background image
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/background/background.jpg"), fit: BoxFit.cover),
            ),
          ),

          // add background image blur and darkening
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(color: Colors.black54),
          ),

          // screen region layout
          Column(
            children: [
              Expanded(
                flex: flexHeader,
                child: LayoutHeader(child: headerChild),
              ),
              Expanded(
                flex: flexMain,
                child: LayoutMain(leftChild: mainLeftChild, centerChild: mainCenterChild, rightChild: mainRightChild),
              ),
              Expanded(
                flex: flexFooter,
                child: LayoutFooter(child: footerChild),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
