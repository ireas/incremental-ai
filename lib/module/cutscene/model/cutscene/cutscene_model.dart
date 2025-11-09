

/// Models a single cutscene.
class CutsceneModel {
  /// Messages that will displayed one at a time during cutscene.
  final List<String> messages;

  /// Image file name in assets/background that will be displayed in the background.
  final String background;

  /// Constructor.
  CutsceneModel({required this.messages, required this.background});
}
