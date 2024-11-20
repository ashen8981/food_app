import 'package:flutter/material.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import 'package:food_app/views/widgets/menu_details_screen/expandable_item.dart';
import 'package:food_app/views/widgets/menu_details_screen/nutritional_tab.dart';
import 'package:food_app/views/widgets/menu_details_screen/size_widget.dart';
import 'package:food_app/views/widgets/menu_details_screen/topping_selector.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../utils/colors.dart';
import '../view_models/menu_details_view_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Item item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => ProductDetailsViewModel(item: item),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: Consumer<ProductDetailsViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.04,
                      right: screenWidth * 0.04,
                      bottom: screenHeight * 0.02,
                      top: screenHeight * 0.002,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.9),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Image.network(
                        item.imageURL,
                        width: double.infinity,
                        height: screenHeight * 0.21,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              item.title.length > 20 ? item.title.substring(0, 20) : item.title,
                              style: TextStyle(
                                color: AppColors.blackTxtColor,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CommonText(
                              '₹${item.deliveryPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                  color: AppColors.blackTxtColor,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.green, size: screenWidth * 0.05),
                                CommonText(
                                  '5.0',
                                  style: TextStyle(
                                      color: AppColors.blackTxtColor,
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CommonText(
                          item.description,
                          style: TextStyle(
                            color: AppColors.greyTxtColor,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CommonText(
                          item.modifierGroupIDs.first,
                          style: TextStyle(
                            color: AppColors.greyTxtColor,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Tab Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => viewModel.selectTab(0),
                              child: CommonText(
                                'Ingredients',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.04,
                                  color: viewModel.selectedTabIndex == 0
                                      ? AppColors.greenBgColor
                                      : AppColors.blackTxtColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => viewModel.selectTab(1),
                              child: CommonText(
                                'Nutritional',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.04,
                                  color: viewModel.selectedTabIndex == 1
                                      ? AppColors.greenBgColor
                                      : AppColors.blackTxtColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => viewModel.selectTab(2),
                              child: CommonText(
                                'Instructions',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.04,
                                  color: viewModel.selectedTabIndex == 2
                                      ? AppColors.greenBgColor
                                      : AppColors.blackTxtColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => viewModel.selectTab(3),
                              child: CommonText(
                                'Allergens',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.04,
                                  color: viewModel.selectedTabIndex == 3
                                      ? AppColors.greenBgColor
                                      : AppColors.blackTxtColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 0.5),
                        SizedBox(height: screenHeight * 0.02),
                        // Content Based on Selected Tab
                        if (viewModel.selectedTabIndex == 0)
                          // Ingredients Content
                          Wrap(
                            spacing: screenWidth * 0.025,
                            runSpacing: screenHeight * 0.005,
                            children: [
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Eggs",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Fish",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Milk",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Mollusks",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Mustard",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Chip(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: AppColors.greyTxt3Color),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                  ),
                                  label: CommonText(
                                    "Gluten",
                                    style: TextStyle(
                                        color: AppColors.greyTxtColor,
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: CommonText(
                                      'See more',
                                      style: TextStyle(
                                        color: AppColors.greenBgColor,
                                        fontSize: screenWidth * 0.032,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: AppColors.greenBgColor,
                                    size: screenWidth * 0.04,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                child: Container(
                                  height: screenHeight * 0.015,
                                  color: AppColors.greyDivColor,
                                ),
                              ),
                              // Toppings Section
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CommonText(
                                  'Toppings',
                                  style: TextStyle(
                                      color: AppColors.blackTxt3Color,
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                children: viewModel.toppings.keys
                                    .map((topping) => ToppingSelector(topping: topping))
                                    .toList(),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                child: Container(
                                  height: screenHeight * 0.03,
                                  color: AppColors.greyDivColor,
                                ),
                              ),
                              ExpandableToppingsWidget(
                                viewModel: viewModel,
                                isSubA: true,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                child: Container(
                                  height: screenHeight * 0.015,
                                  color: AppColors.greyDivColor,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Choose Size Section
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CommonText(
                                  'Choose Size',
                                  style: TextStyle(
                                      color: AppColors.blackTxt3Color,
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight * 0.025, bottom: screenHeight * 0.025),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildSizeOption(viewModel, "Small", 0),
                                    const Spacer(),
                                    buildSizeOption(viewModel, "Medium", 1),
                                    const Spacer(),
                                    buildSizeOption(viewModel, "Large", 2),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                child: Container(
                                  height: screenHeight * 0.015,
                                  color: AppColors.greyDivColor,
                                ),
                              ),
                              // Add Comments Section
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight * 0.025, bottom: screenHeight * 0.01),
                                child: CommonText(
                                  'Add Comments (Optional)',
                                  style: TextStyle(
                                      color: AppColors.blackTxt2Color,
                                      fontSize: screenWidth * 0.038,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              const TextField(
                                decoration: InputDecoration(
                                  hintText: "Write here",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.greyTxt3Color,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.greyTxt3Color,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.greyTxt3Color,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              // Quantity and Add to Cart Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Quantity Selector Container
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.greenBg2Color,
                                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03,
                                      vertical: screenHeight * 0.012,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: viewModel.decrementQuantity,
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColors.greenBgColor,
                                            size: screenWidth * 0.05,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.08),
                                        CommonText(
                                          viewModel.quantity.toString(),
                                          style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: screenWidth * 0.08),
                                        GestureDetector(
                                          onTap: viewModel.incrementQuantity,
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.greenBgColor,
                                            size: screenWidth * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // "Add to Cart" Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.greenBgColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.085, vertical: screenHeight * 0.015),
                                    ),
                                    onPressed: () {
                                      // Handle add to cart functionality here
                                    },
                                    child: CommonText(
                                      "Add to Cart ₹${viewModel.totalPrice.toStringAsFixed(0)}",
                                      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: screenHeight * 0.03, horizontal: screenWidth * 0.25),
                                child: Container(
                                  height: screenHeight * 0.008,
                                  decoration: BoxDecoration(
                                    color: AppColors.blackTxtColor,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.015),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else if (viewModel.selectedTabIndex == 1)
                          // Nutritional Content
                          const NutritionalInfo(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
