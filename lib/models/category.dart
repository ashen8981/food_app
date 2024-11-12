import 'menu_item.dart';

class Category {
  final String id;
  final String menuCategoryID;
  final String menuID;
  final String title;
  final List<MenuItemE> menuItems;

  Category(
      {required this.id,
      required this.menuCategoryID,
      required this.menuID,
      required this.title,
      required this.menuItems});

  factory Category.fromJson(Map<String, dynamic> json) {
    var menuEntities = json['MenuEntities'] as List;
    List<MenuItemE> itemsList = menuEntities.map((item) => MenuItemE.fromJson(item)).toList();

    return Category(
      id: json['ID'],
      menuCategoryID: json['MenuCategoryID'],
      menuID: json['MenuID'],
      title: json['Title']['en'],
      menuItems: itemsList,
    );
  }
}
