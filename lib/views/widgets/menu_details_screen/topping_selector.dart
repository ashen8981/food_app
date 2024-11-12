import 'package:flutter/material.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import 'package:food_app/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../view_models/menu_details_view_model.dart';

class ToppingSelector extends StatelessWidget {
  final String topping;

  const ToppingSelector({super.key, required this.topping});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductDetailsViewModel>(context);
    bool isAddSelected = viewModel.selectedAddTopping == topping;
    bool isRemoveSelected = viewModel.selectedRemoveTopping == topping;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            topping,
            style: const TextStyle(
              color: AppColors.blackTxt3Color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              // Remove Button
              Container(
                height: screenHeight * 0.035,
                width: screenHeight * 0.035,
                decoration: BoxDecoration(
                  color: isRemoveSelected ? AppColors.greenBgColor : Colors.white,
                  border: Border.all(
                    color: AppColors.greyTxt3Color,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    icon: Icon(
                      Icons.remove,
                      color: isRemoveSelected ? Colors.white : AppColors.blackTxt3Color,
                    ),
                    onPressed: () {
                      viewModel.decrementTopping(topping);
                    },
                  ),
                ),
              ),
              // Topping Quantity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonText(
                  viewModel.toppings[topping].toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: AppColors.blackTxt3Color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Add Button
              Container(
                height: screenHeight * 0.035,
                width: screenHeight * 0.035,
                decoration: BoxDecoration(
                  color: isAddSelected ? AppColors.greenBgColor : Colors.white,
                  border: Border.all(
                    color: AppColors.greyTxt3Color,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    icon: Icon(
                      Icons.add,
                      color: isAddSelected ? Colors.white : AppColors.blackTxt3Color,
                    ),
                    onPressed: () {
                      viewModel.incrementTopping(topping);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
