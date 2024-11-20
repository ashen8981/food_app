import 'package:flutter/cupertino.dart';
import '../models/item.dart';
import '../models/menu.dart';
import '../repositories/menu_repository.dart';

class ItemViewModel extends ChangeNotifier {
  final MenuRepository repository;
  Map<String, List<Item>> itemsByCategory = {};
  List<Item> allItems = [];
  String? selectedCategoryID;

  int batchSize = 10; // Number of items to load per batch
  int currentBatchIndex = 0; // Track the current loading index

  ItemViewModel(this.repository);

  // Loads items for all categories based on the menus provided
  Future<void> loadItemsForAllCategories(List<Menu> menus) async {
    for (var menu in menus) {
      final categoryID = menu.menuID;
      if (!itemsByCategory.containsKey(categoryID)) {
        final items = await repository.fetchItemsForCategory(categoryID, menu.title);
        itemsByCategory[categoryID] = items;
        allItems.addAll(items);
      }
    }
    loadNextBatch(); // Load initial batch
    notifyListeners();
  }

  // Load the next batch of items
  void loadNextBatch() {
    currentBatchIndex += batchSize;
    notifyListeners();
  }

  // Retrieves items for the selected category, up to the current batch size
  List<Item> getItemsForSelectedCategory() {
    final items = selectedCategoryID == null ? allItems : itemsByCategory[selectedCategoryID] ?? [];

    // Return items up to the current batch size
    return items.take(currentBatchIndex).toList();
  }
}
