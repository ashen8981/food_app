import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/item.dart';
import '../models/menu.dart';

class MenuRepository {
  Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/menus.json');
    return json.decode(jsonString);
  }

  Future<List<Menu>> fetchMenus() async {
    final jsonData = await loadJsonData();
    return (jsonData['Result']['Menu'] as List).map((json) => Menu.fromJson(json)).toList();
  }

  Future<List<Item>> fetchItemsForCategory(String categoryID, String menuTitle) async {
    final jsonData = await loadJsonData();

    final category = (jsonData['Result']['Categories'] as List)
        .firstWhere((json) => json['MenuID'] == categoryID, orElse: () => null);

    if (category == null) return [];

    final menuEntityIDs = (category['MenuEntities'] as List).map((entity) => entity['ID']).toSet();

    final items = (jsonData['Result']['Items'] as List)
        .where((item) => menuEntityIDs.contains(item['MenuItemID']))
        .map((item) => Item.fromJson(item, menuTitle)) // Pass menuTitle to Item
        .toList();

    return items;
  }
}
