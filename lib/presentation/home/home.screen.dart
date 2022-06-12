import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';

import 'package:technical_test/presentation/cart/widget/cart_icon.widget.dart';
import 'package:technical_test/presentation/home/widget/home_loading_card.widget.dart';
import 'package:technical_test/presentation/product/controllers/product.controller.dart';
import 'package:technical_test/presentation/product/product_detail.screen.dart';
import 'package:technical_test/presentation/product/widget/product_card.widget.dart';

import 'package:technical_test/presentation/product/widget/product_search.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());
  final ScrollController scrollController = ScrollController();
  TextEditingController tSearchProduct = TextEditingController();
  int page = 1;
  @override
  void initState() {
    refreshData();
    super.initState();
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if (!productController.isLoadMore!.value && !productController.isLoading!.value) {
            page++;
            productController.fetchMoreProduct(tSearchProduct.text, page);
          }
        }
      }
    });
  }

  void refreshData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      productController.fetchProduct(1, true);
    } else {
      productController.fetchProduct(1, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                top: false,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Center(
                          child: Text(
                            'Discover',
                            style: heading1TextStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 5,
                                child: ProductSearchWidget(
                                  tController: tSearchProduct,
                                )),
                            Flexible(flex: 1, child: CartIconWidget())
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'New Trend',
                          style: heading1TextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: GetX<ProductController>(
                              init: ProductController(),
                              builder: (data) {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    return refreshData();
                                  },
                                  color: Colors.black,
                                  child: data.isLoading!.value && !data.isLoadMore!.value
                                      ? HomeLoadingCardWidget()
                                      : GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 2,
                                            childAspectRatio: 0.54,
                                          ),
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          itemCount: data.productData.length,
                                          itemBuilder: (ctx, i) {
                                            return ProductCardWidget(
                                              item: data.productData[i],
                                              onTap: () {
                                                print(data.productData[i]);
                                                Get.to(() => ProductDetailScreen(
                                                      product: data.productData[i],
                                                    ));
                                              },
                                            );
                                          }),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
