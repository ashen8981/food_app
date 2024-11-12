import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../models/menu.dart';
import '../../../view_models/menu_view_model.dart';
import '../common_widget/common_text.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedMenuTitle;
  final Function(String title, String? menuID) onCategorySelected;
  final Future<void> initialLoadFuture;

  const CategoryFilter({
    super.key,
    required this.selectedMenuTitle,
    required this.onCategorySelected,
    required this.initialLoadFuture,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialLoadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer<MenuViewModel>(
          builder: (context, model, child) {
            final List<Menu> allMenus =
                [Menu(id: 'all', menuID: 'all', title: 'All Items', menuCategoryIDs: [])] + model.menus;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: allMenus.map((menu) {
                  bool isSelected = selectedMenuTitle == menu.title;
                  return GestureDetector(
                    onTap: () {
                      onCategorySelected(menu.title, menu.menuID == 'all' ? null : menu.menuID);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.greenBgColor : AppColors.textBgColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CommonText(
                        menu.title,
                        style: TextStyle(
                            color: isSelected ? AppColors.textBgColor : AppColors.blackTxtColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
