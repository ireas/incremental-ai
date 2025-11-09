import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:incremental_ai/module/cutscene/action/cutscene_manage_action.dart';
import 'package:incremental_ai/module/cutscene/model/cutscene/cutscene_model.dart';
import 'package:incremental_ai/engine/widget/button/multi_click_button.dart';
import 'package:incremental_ai/engine/widget/panel/section_panel.dart';
import 'package:incremental_ai/engine/widget/theme/theme_colors.dart';

/// Displays a single cutscene.
/// Shows a background image and multiple texts as overlay with some neat looking animations.
///
/// TODO: stop cycle timer while cutscene is shown
class CutsceneOverlay extends StatefulWidget {
  /// Displayed cutscene.
  final CutsceneModel model;

  /// Constructor.
  const CutsceneOverlay({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _CutsceneOverlay();
}

class _CutsceneOverlay extends State<CutsceneOverlay> {
  /// Counter that tracks how many messages should be shown at any moment.
  int _currentMessageIndex = 0;

  /// Timer that increases the message index.
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // if time is over, show next message
      if (_currentMessageIndex < widget.model.messages.length) {
        setState(() {
          _currentMessageIndex++;
        });
      } else {
        // stop when all messages are shown
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void onClick() {
    if (_currentMessageIndex == widget.model.messages.length) {
      CutsceneManageAction.instance.closeCurrentCutscene();
    } else {
      _timer?.cancel();
      setState(() {
        _currentMessageIndex++;
      });
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    // filter how many message are visible currently
    List<Widget> visibleMessages = widget.model.messages.getRange(0, _currentMessageIndex).toList().asMap().entries.map(
      (entry) {
        final int index = entry.key;
        final String message = entry.value;

        return Animate(
          // key ensures animation runs once per new message
          key: ValueKey(index),
          effects: [FadeEffect()],
          child: Text(message),
        );
      },
    ).toList();

    return SafeArea(
      child: Animate(
        effects: [FadeEffect(duration: Duration(seconds: 1))],
        child: MultiClickButton(
          onLeftClick: () => onClick(),
          child: Container(
            color: context.colors.panelDark,
            child: Stack(
              // stack takes up full window space
              fit: StackFit.expand,
              children: [
                Animate(
                  effects: [FadeEffect(delay: Duration(seconds: 1), duration: Duration(seconds: 1))],
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background/${widget.model.background}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // add background image blur and darkening
                BackdropFilter(filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)),

                // animated texts in label
                Animate(
                  effects: [FadeEffect(delay: Duration(seconds: 1), duration: Duration(seconds: 1))],
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SectionPanel(
                      child: Column(spacing: 6, mainAxisAlignment: MainAxisAlignment.start, children: visibleMessages),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
