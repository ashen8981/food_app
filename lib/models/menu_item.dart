class MenuItemE {
  final String id;
  final String type;

  MenuItemE({required this.id, required this.type});

  factory MenuItemE.fromJson(Map<String, dynamic> json) {
    return MenuItemE(
      id: json['ID'],
      type: json['Type'],
    );
  }
}
