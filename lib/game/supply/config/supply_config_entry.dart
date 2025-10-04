class SupplyConfigEntry {
  static const List<String> requiredParameters = ["id", "color", "description"];
  final String id;
  final String color;
  final String description;

  SupplyConfigEntry(this.id, this.color, this.description);

  factory SupplyConfigEntry.fromMap(Map<String, dynamic> yaml) {
    _validate(yaml);

    return SupplyConfigEntry(
      yaml['id'].toString(),
      yaml['color'].toString(),
      yaml['description'].toString(),
    );
  }

  static void _validate(Map<String, dynamic> map) {
    for (String parameter in requiredParameters) {
      if (map[parameter] == null || map[parameter].toString().trim().isEmpty) {
        throw FormatException("Missing required parameter '$parameter'!");
      }
    }
  }

  @override
  String toString() {
    return '$runtimeType (id: $id, color: $color, description: $description)';
  }
}
