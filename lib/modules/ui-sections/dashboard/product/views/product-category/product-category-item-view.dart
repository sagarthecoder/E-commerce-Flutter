import 'package:flutter/material.dart';

class ProductCategoryItemCell extends StatelessWidget {
  final String categoryName;
  final Function(String) onTap; // Update the callback type

  ProductCategoryItemCell(
      {required this.categoryName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(categoryName), // Pass categoryName to the callback
      child: Container(
        height: 40,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
