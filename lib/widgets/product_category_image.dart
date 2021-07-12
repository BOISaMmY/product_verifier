import 'package:flutter/material.dart';

class ProductCategoryImage extends StatelessWidget {
  final String category;
  ProductCategoryImage(this.category);
  String getImagePath(String s) {
    if (s == 'accessory')
      return 'assets/images/accessories.png';
    else if (s == 'appliance')
      return 'assets/images/appliances.png';
    else if (s == 'gadget')
      return 'assets/images/gadgets.png';
    else if (s == 'grocery')
      return 'assets/images/groceries.png';
    else if (s == 'stationary')
      return 'assets/images/stationaries.png';
    else
      return 'assets/images/unknown.png';
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      getImagePath(category),
      fit: BoxFit.contain,
    );
  }
}
