import 'package:flutter/material.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import 'package:food_app/utils/colors.dart';

class NutritionalInfo extends StatelessWidget {
  const NutritionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          'Nutritional value per 100g',
          style: const TextStyle(
            color: AppColors.blackTxtColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNutritionalColumn('198', 'Kcal'),
            _buildNutritionalColumn('14.1', 'Proteins'),
            _buildNutritionalColumn('19.6', 'Fats'),
            _buildNutritionalColumn('6.6', 'Carbo H'),
          ],
        ),
      ],
    );
  }

  // Helper widget for each nutrient
  Widget _buildNutritionalColumn(String value, String label) {
    return Column(
      children: [
        CommonText(
          value,
          style: const TextStyle(
            color: AppColors.blackTxtColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        CommonText(
          label,
          style: const TextStyle(color: AppColors.greyTxt4Color),
        ),
      ],
    );
  }
}
