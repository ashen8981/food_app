class ModifierGroup {
  final String id;
  final String modifierGroupID;
  final String title;
  final String description;
  final String storeID;
  final String displayType;
  final List<ModifierOption> modifierOptions;
  final dynamic overrides;

  ModifierGroup({
    required this.id,
    required this.modifierGroupID,
    required this.title,
    required this.description,
    required this.storeID,
    required this.displayType,
    required this.modifierOptions,
    this.overrides,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json) {
    return ModifierGroup(
      id: json['ID'],
      modifierGroupID: json['ModifierGroupID'],
      title: json['Title']['en'],
      description: json['Description']['en'] ?? '',
      storeID: json['StoreID'],
      displayType: json['DisplayType'],
      modifierOptions: (json['ModifierOptions'] as List).map((option) => ModifierOption.fromJson(option)).toList(),
      overrides: json['Overrides'],
    );
  }
}

class ModifierOption {
  final String id;
  final String type;

  ModifierOption({
    required this.id,
    required this.type,
  });

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    return ModifierOption(
      id: json['Id'],
      type: json['Type'],
    );
  }
}
