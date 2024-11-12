import 'package:flutter/material.dart';
import '../models/item.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  final Item item;

  int quantity = 1;
  int selectedSizeIndex = 1;
  Map<String, int> toppings = {
    "Beef": 0,
    "Smoked Beef": 1,
    "Mozarella Cheese": 1,
    "Mushroom": 1,
    "Paprika": 0,
  };

  int selectedTabIndex = 0;
  String? selectedAddTopping; // Tracks selected topping for the add button
  String? selectedRemoveTopping; // Tracks selected topping for the remove button

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

  void incrementTopping(String topping) {
    toppings[topping] = (toppings[topping] ?? 0) + 1;
    selectedAddTopping = topping; // Update the selected add button topping
    selectedRemoveTopping = null; // Clear the remove selection
    notifyListeners();
  }

  void decrementTopping(String topping) {
    if ((toppings[topping] ?? 0) > 0) {
      toppings[topping] = (toppings[topping] ?? 0) - 1;
      selectedRemoveTopping = topping; // Update the selected remove button topping
      selectedAddTopping = null; // Clear the add selection
      notifyListeners();
    }
  }

  void changeSize(int sizeIndex) {
    selectedSizeIndex = sizeIndex;
    notifyListeners();
  }

  double get totalPrice => item.deliveryPrice * quantity;
}
