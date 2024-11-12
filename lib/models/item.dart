class Item {
  final String id;
  final String menuItemID;
  final String storeID;
  final String title;
  final String description;
  final String imageURL;
  final String menuTitle;
  final double deliveryPrice;
  final bool isDealProduct;

  Item({
    required this.id,
    required this.menuItemID,
    required this.storeID,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.menuTitle,
    required this.deliveryPrice,
    required this.isDealProduct,
  });

  factory Item.fromJson(Map<String, dynamic> json, String menuTitle) {
    // Accept menuTitle as parameter
    return Item(
      id: json['ID'],
      menuItemID: json['MenuItemID'],
      storeID: json['StoreID'],
      title: json['Title']['en'],
      description: json['Description']['en'],
      imageURL: json['ImageURL'] ?? '',
      menuTitle: menuTitle, // Set the menu title
      deliveryPrice: json['PriceInfo']['Price']['DeliveryPrice']?.toDouble() ?? 0.0,
      isDealProduct: json['MetaData']['IsDealProduct'] ?? false,
    );
  }
}
