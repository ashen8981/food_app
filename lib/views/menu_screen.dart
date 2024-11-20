import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/view_models/item_view_model.dart';
import 'package:food_app/view_models/menu_view_model.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import 'package:food_app/views/widgets/menu_screen/bottom_button.dart';
import 'package:food_app/views/widgets/menu_screen/category_dropdown.dart';
import 'package:food_app/views/widgets/menu_screen/menu_item_widget.dart';
import 'package:food_app/views/widgets/menu_screen/search.dart';
import 'package:food_app/views/widgets/menu_screen/toggle_button.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  late Future<void> _initialLoadFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final menuViewModel = Provider.of<MenuViewModel>(context, listen: false);
    final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
    _initialLoadFuture = menuViewModel.loadMenusAndItems(itemViewModel);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        itemViewModel.loadNextBatch();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top section: Background image, title, toggle button
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                'assets/images/menu_bg_img_1.png',
                width: screenWidth,
                height: screenHeight * 0.25,
                fit: BoxFit.cover,
              ),
              Container(
                width: screenWidth,
                height: screenHeight * 0.23,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(0, 0, 0, 1),
                    ],
                    stops: [0.1, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.06,
                left: screenWidth * 0.04,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      'El Cabanyal',
                      style: TextStyle(color: AppColors.textBgColor, fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    CommonText(
                      'FASTFOOD · BURGERS',
                      style: TextStyle(color: AppColors.textBgColor, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -screenHeight * 0.03,
                child: const ToggleButton(initialIndex: 0),
              ),
              Positioned(
                top: screenHeight * 0.12,
                right: screenWidth * 0.06,
                child: CircleAvatar(
                  radius: screenHeight * 0.04,
                  backgroundColor: Colors.red,
                  child: const CommonText(
                    '小红书',
                    style: TextStyle(color: AppColors.textBgColor, fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
            child: const MenuDropdownAndSearch(),
          ),
          SizedBox(height: screenHeight * 0.025),
          // Category filter section
          Consumer<MenuViewModel>(
            builder: (context, menuViewModel, child) {
              return CategoryFilter(
                selectedMenuTitle: menuViewModel.selectedMenuTitle,
                onCategorySelected: (title, menuID) =>
                    menuViewModel.selectCategory(title, menuID, Provider.of<ItemViewModel>(context, listen: false)),
                initialLoadFuture: _initialLoadFuture,
              );
            },
          ),
          // Main section: Grouped menu items
          Expanded(
            child: Consumer<ItemViewModel>(
              builder: (context, itemViewModel, child) {
                // Map to group items by menuTitle
                final groupedItems = <String, List<Item>>{};
                final items = itemViewModel.getItemsForSelectedCategory();

                // Group items based on their menuTitle
                for (var item in items) {
                  groupedItems.putIfAbsent(item.menuTitle, () => []).add(item);
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: groupedItems.length,
                  itemBuilder: (context, groupIndex) {
                    final menuTitle = groupedItems.keys.elementAt(groupIndex);
                    final itemList = groupedItems[menuTitle]!;
                    // Display each group (menuTitle and its items)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.04,
                          ),
                          child: CommonText(
                            menuTitle,
                            style: const TextStyle(
                              color: AppColors.blackTxtColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // List of items under the current menuTitle
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemList.length,
                          itemBuilder: (context, itemIndex) {
                            return Column(
                              children: [
                                if (itemIndex > 0)
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                                    child: const Divider(color: AppColors.greyBgColor),
                                  ),
                                buildMenuItem(context, itemList[itemIndex]),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                          child: Container(
                            height: screenHeight * 0.015,
                            color: AppColors.greyDivColor,
                          ),
                        ),
                        if (groupIndex == groupedItems.length - 1)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenHeight * 0.02,
                            ),
                            child: const BasketFooter(
                              itemCount: 3,
                              totalAmount: 24.00,
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
