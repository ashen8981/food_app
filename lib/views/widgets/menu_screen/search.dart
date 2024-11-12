import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../common_widget/common_text.dart';

class MenuDropdownAndSearch extends StatefulWidget {
  const MenuDropdownAndSearch({super.key});

  @override
  MenuDropdownAndSearchState createState() => MenuDropdownAndSearchState();
}

class MenuDropdownAndSearchState extends State<MenuDropdownAndSearch> {
  final List<Map<String, String>> menuItems = [
    {'title': 'Lunch Menu', 'time': '10am - 5pm'},
    {'title': 'Breakfast Menu', 'time': '5pm - 11pm'},
  ];
  String selectedMenu = 'Lunch Menu';

  void _showMenuSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CommonText('Select menu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                        icon: Icon(Icons.close_outlined),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.greyBgColor),
                  SizedBox(height: 16.0),
                  ...menuItems.map((menu) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyBgColor), // Set border color here
                        borderRadius: BorderRadius.circular(8.0), // Add rounded corners if needed
                      ),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0), // Adjust padding for alignment
                        title: Row(
                          children: [
                            CommonText(
                              menu['title']!,
                              style: const TextStyle(
                                  color: AppColors.blackBgColor, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            CommonText(
                              ".",
                              style: const TextStyle(
                                  color: AppColors.blackBgColor, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            CommonText(
                              menu['time']!,
                              style: const TextStyle(
                                  color: AppColors.blackBgColor, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        trailing: Radio<String>(
                          value: menu['title']!,
                          activeColor: AppColors.greenBgColor,
                          groupValue: selectedMenu,
                          onChanged: (String? value) {
                            setModalState(() {
                              // This updates the bottom sheet's state
                              selectedMenu = value!;
                            });
                            setState(() {}); // This updates the main widget's state
                          },
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close the popup only when "Done" is tapped
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: AppColors.greenBgColor,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Center(
                        child: CommonText(
                          "Done",
                          style:
                              const TextStyle(color: AppColors.textBgColor, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _showMenuSheet(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                CommonText(
                  selectedMenu,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {
            // Handle search icon press
          },
        ),
      ],
    );
  }
}
