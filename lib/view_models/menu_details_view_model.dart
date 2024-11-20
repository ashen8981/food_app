import 'package:flutter/material.dart';
import '../models/item.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  final Item item;

  int quantity = 1;
  int selectedSizeIndex = 1;

  // Separate state for Toppings
  Map<String, int> toppings = {
    "Beef": 0,
    "Smoked Beef": 1,
    "Mozarella Cheese": 1,
    "Mushroom": 1,
    "Paprika": 0,
  };

  // Separate state for Sub A
  Map<String, int> subAItems = {
    "Beef": 0,
    "Smoked Beef": 1,
    "Mozarella Cheese": 1,
    "Mushroom": 1,
    "Paprika": 2,
  };

  int selectedTabIndex = 0;
  String? selectedAddTopping; // Tracks selected topping for the add button
  String? selectedRemoveTopping; // Tracks selected topping for the remove button

  String? selectedAddSubAItem; // Tracks selected Sub A item for the add button
  String? selectedRemoveSubAItem; // Tracks selected Sub A item for the remove button

  ProductDetailsViewModel({required this.item});

  void selectTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  // Manage Topping State
  void incrementTopping(String topping) {
    toppings[topping] = (toppings[topping] ?? 0) + 1;
    selectedAddTopping = topping;
    selectedRemoveTopping = null;
    notifyListeners();
  }

  void decrementTopping(String topping) {
    if ((toppings[topping] ?? 0) > 0) {
      toppings[topping] = (toppings[topping] ?? 0) - 1;
      selectedRemoveTopping = topping;
      selectedAddTopping = null;
      notifyListeners();
    }
  }

  // Manage Sub A State
  void incrementSubAItem(String subAItem) {
    subAItems[subAItem] = (subAItems[subAItem] ?? 0) + 1;
    selectedAddSubAItem = subAItem;
    selectedRemoveSubAItem = null;
    notifyListeners();
  }

  void decrementSubAItem(String subAItem) {
    if ((subAItems[subAItem] ?? 0) > 0) {
      subAItems[subAItem] = (subAItems[subAItem] ?? 0) - 1;
      selectedRemoveSubAItem = subAItem;
      selectedAddSubAItem = null;
      notifyListeners();
    }
  }

  void changeSize(int sizeIndex) {
    selectedSizeIndex = sizeIndex;
    notifyListeners();
  }

  double get totalPrice => item.deliveryPrice * quantity;
}
