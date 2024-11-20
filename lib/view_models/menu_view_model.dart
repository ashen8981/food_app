import 'package:flutter/cupertino.dart';
import '../models/menu.dart';
import '../repositories/menu_repository.dart';
import 'item_view_model.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository repository;
  List<Menu> menus = [];
  String selectedMenuTitle = 'All Items';
  String? selectedCategoryID;

  MenuViewModel(this.repository);

  // Loads menus and items into the itemViewModel
  Future<void> loadMenusAndItems(ItemViewModel itemViewModel) async {
    menus = await repository.fetchMenus();
    await itemViewModel.loadItemsForAllCategories(menus);
    notifyListeners();
  }

  // Selects a category and updates the corresponding itemViewModel
  void selectCategory(String title, String? menuID, ItemViewModel itemViewModel) {
    selectedMenuTitle = title;
    selectedCategoryID = menuID;
    itemViewModel.selectedCategoryID = menuID;
    itemViewModel.notifyListeners();
    notifyListeners();
  }
}
