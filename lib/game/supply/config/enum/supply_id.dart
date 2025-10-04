enum SupplyId { mana, metal, scrap}

extension SupplyIdExtention on SupplyId {
  String string() {
    return name;
  }

  static SupplyId? from(String id) {
    for (final entry in SupplyId.values) {
      if (entry.name == id) {
        return entry;
      }
    }
    return null;
  }
}
