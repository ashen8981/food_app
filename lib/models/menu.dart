class Menu {
  final String id;
  final String menuID;
  final String title;
  final List<String> menuCategoryIDs;

  Menu({required this.id, required this.menuID, required this.title, required this.menuCategoryIDs});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      menuID: json['MenuID'],
      title: json['Title']['en'],
      menuCategoryIDs: List<String>.from(json['MenuCategoryIDs']),
    );
  }
}
