import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/presentation/product/controllers/product.controller.dart';
import 'package:technical_test/presentation/product/product_search.screen.dart';

class ProductSearchWidget extends StatelessWidget {
  final TextEditingController? tController;
  ProductSearchWidget({Key? key, this.tController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: new BorderRadius.circular(8),
      ),
      child: TextField(
        controller: tController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) async {
          if (value.isNotEmpty) {
            productController.searchProduct(value);
            Get.to(() => ProductSearchScreen());
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Remix.search_2_line, color: greyColor),
          hintText: 'Search Product',
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
