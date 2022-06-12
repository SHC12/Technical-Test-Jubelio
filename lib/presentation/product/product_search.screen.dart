import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';
import 'package:technical_test/presentation/cart/widget/cart_icon.widget.dart';
import 'package:technical_test/presentation/product/controllers/product.controller.dart';
import 'package:technical_test/presentation/product/product_detail.screen.dart';
import 'package:technical_test/presentation/product/widget/product_card.widget.dart';
import 'package:technical_test/presentation/product/widget/product_card_loading.widget.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(builder: (data) {
      return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: (data.isLoading!.value && data.searchData.isEmpty)
              ? AnimatedList(
                  initialItemCount: 10,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Tween(begin: const Offset(1, 0), end: const Offset(0, 0))),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 0.70,
                            ),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (ctx, i) => const ProductCardLoadingWidget()),
                      ),
                    );
                  })
              : (!data.isLoading!.value && data.searchData.isEmpty)
                  ? Center(
                      child: Text('No Result Found'),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Remix.arrow_left_s_line)),
                              Text(
                                'Search Result',
                                style: heading1TextStyle,
                              ),
                              CartIconWidget()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 0.58,
                                ),
                                shrinkWrap: true,
                                itemCount: data.searchData.length,
                                itemBuilder: (ctx, i) {
                                  return ProductCardWidget(
                                    item: data.searchData[i],
                                    onTap: () {
                                      Get.to(() => ProductDetailScreen(
                                            product: data.searchData[i],
                                          ));
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
        ),
      );
    });
  }
}
