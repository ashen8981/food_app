import 'package:flutter/material.dart';
import 'package:food_app/views/widgets/common_widget/common_text.dart';
import '../../../models/item.dart';
import '../../../utils/colors.dart';
import '../../menu_details_screen.dart';

Widget buildMenuItem(BuildContext context, Item item) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(item: item),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2), // Space between the image and the border
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5), // Border color and width
                  borderRadius: BorderRadius.circular(8.0), // Match the ClipRRect border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    item.imageURL,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      item.title,
                      style: const TextStyle(color: AppColors.blackTxtColor, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4.0),
                    CommonText(
                      _truncateText(item.description, 2),
                      style: const TextStyle(color: AppColors.blackTxtColor, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        CommonText(
                          "\$${(item.deliveryPrice).toStringAsFixed(2)}", // Convert to dollars and format to 2 decimal places
                          style:
                              const TextStyle(color: AppColors.greenBgColor, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        item.isDealProduct
                            ? Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: 4, horizontal: 16), // Add padding around the text
                                decoration: BoxDecoration(
                                  color: AppColors.orangeBgColor, // Set the background color to yellow
                                  borderRadius: BorderRadius.circular(12), // Set the curve for rounded corners
                                ),
                                child: CommonText(
                                  "Promotions Available", // Display promotion message
                                  style: const TextStyle(
                                      color: AppColors.blackTxtColor, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              )
                            : SizedBox.shrink(), // If no promotion, return an empty widget
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

String _truncateText(String text, int wordLimit) {
  List<String> words = text.split(' ');
  if (words.length > wordLimit) {
    return '${words.take(wordLimit).join(' ')}...';
  }
  return text;
}
