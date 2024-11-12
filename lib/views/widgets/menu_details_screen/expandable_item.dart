import 'package:flutter/material.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import '../../../utils/colors.dart';
import '../../../view_models/menu_details_view_model.dart';

class ExpandableToppingsWidget extends StatefulWidget {
  final ProductDetailsViewModel viewModel;

  const ExpandableToppingsWidget({super.key, required this.viewModel});

  @override
  ExpandableToppingsWidgetState createState() => ExpandableToppingsWidgetState();
}

class ExpandableToppingsWidgetState extends State<ExpandableToppingsWidget> {
  bool _isExpanded = false; // Track expansion state

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded; // Toggle expansion state
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.015,
              horizontal: screenWidth * 0.02,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    'Sub A',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackTxt3Color,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: screenWidth * 0.06,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: Column(
              children: widget.viewModel.toppings.keys.map((topping) {
                bool isAddSelected = widget.viewModel.selectedAddTopping == topping;
                bool isRemoveSelected = widget.viewModel.selectedRemoveTopping == topping;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0075),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        topping,
                        style: TextStyle(
                          color: AppColors.blackTxt3Color,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: screenHeight * 0.035,
                            width: screenHeight * 0.035,
                            decoration: BoxDecoration(
                              color: isRemoveSelected ? AppColors.greenBgColor : Colors.white,
                              border: Border.all(
                                color: AppColors.greyTxt3Color,
                                width: screenWidth * 0.004,
                              ),
                              borderRadius: BorderRadius.circular(screenWidth * 0.015),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: screenWidth * 0.045,
                                icon: Icon(
                                  Icons.remove,
                                  color: isRemoveSelected ? Colors.white : AppColors.blackTxt3Color,
                                ),
                                onPressed: () {
                                  widget.viewModel.decrementTopping(topping);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                            child: Text(
                              widget.viewModel.toppings[topping].toString().padLeft(2, '0'),
                              style: TextStyle(
                                color: AppColors.blackTxt3Color,
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.035,
                            width: screenHeight * 0.035,
                            decoration: BoxDecoration(
                              color: isAddSelected ? AppColors.greenBgColor : Colors.white,
                              border: Border.all(
                                color: AppColors.greyTxt3Color,
                                width: screenWidth * 0.004,
                              ),
                              borderRadius: BorderRadius.circular(screenWidth * 0.015),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: screenWidth * 0.045,
                                icon: Icon(
                                  Icons.add,
                                  color: isAddSelected ? Colors.white : AppColors.blackTxt3Color,
                                ),
                                onPressed: () {
                                  widget.viewModel.incrementTopping(topping);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
