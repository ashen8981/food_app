import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../view_models/menu_details_view_model.dart';

Widget buildSizeOption(ProductDetailsViewModel viewModel, String label, int index) {
  bool isSelected = viewModel.selectedSizeIndex == index;

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () => viewModel.changeSize(index),
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenBgColor : Colors.transparent,
            border: Border.all(
              color: AppColors.greenBgColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: isSelected ? Icon(Icons.square, color: Colors.white, size: 16.0) : null,
        ),
      ),
      SizedBox(width: 8.0),
      Text(label),
    ],
  );
}
