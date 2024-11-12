import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../common_widget/common_text.dart';

class BasketFooter extends StatelessWidget {
  final int itemCount;
  final double totalAmount;

  const BasketFooter({
    super.key,
    required this.itemCount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust padding as needed
            decoration: BoxDecoration(
              color: AppColors.greenBgColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Center(
              child: CommonText(
                "Basket · $itemCount items · £${totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(color: AppColors.textBgColor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity, // Makes the button take the maximum width
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.0), // Remove horizontal padding for full-width
              side: BorderSide(color: AppColors.greenBgColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              backgroundColor: Colors.green.shade50, // Light background
            ),
            onPressed: () {
              // Implement view basket action
            },
            child: CommonText(
              "View Basket",
              style: const TextStyle(color: AppColors.greenBgColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
          child: Container(
            height: 6.0,
            decoration: BoxDecoration(
              color: AppColors.blackTxtColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ],
    );
  }
}
