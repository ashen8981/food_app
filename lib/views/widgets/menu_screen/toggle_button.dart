import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';

class ToggleButton extends StatefulWidget {
  final int initialIndex;

  const ToggleButton({super.key, required this.initialIndex});

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    int clampedIndex = widget.initialIndex.clamp(0, 2);
    isSelected = [false, false, false];
    isSelected[clampedIndex] = true;
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        print("1");
        break;
      case 1:
        print("2");
        break;
      case 2:
        print("3");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderWidth: 0,
      selectedColor: Colors.white,
      borderRadius: BorderRadius.circular(18),
      fillColor: Colors.transparent,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
        navigateToPage(index);
      },
      isSelected: isSelected,
      children: [
        _buildToggleImage('assets/icons/icon_1.png', 0),
        _buildToggleImage('assets/icons/icon_2.png', 1),
        _buildToggleImage('assets/icons/icon_3.png', 2),
      ],
    );
  }

  // Method to build each button with different background colors
  Widget _buildToggleImage(String imagePath, int index) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected[index] ? AppColors.toggleBtBgColor : Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: Image.asset(
        imagePath,
        width: 30, // Set the width for the icon size
        height: 30, // Set the height for the icon size
        color: isSelected[index] ? AppColors.greenBgColor : AppColors.blackBgColor,
      ),
    );
  }
}
