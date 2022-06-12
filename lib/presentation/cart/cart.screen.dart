import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';
import 'package:technical_test/data/helper/util/utils.helper.dart';
import 'package:technical_test/presentation/cart/widget/cart_card.widget.dart';

import 'controllers/cart.controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    cartController.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Remix.arrow_left_s_line)),
                      Text(
                        'My Cart',
                        style: heading1TextStyle,
                      ),
                      Container()
                    ],
                  ),
                ),
              ),
              Obx(() => Flexible(
                    flex: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: Column(
                          children: cartController.cartList.map((element) {
                            return CartCardWidget(
                              cart: element,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )),
              Flexible(
                flex: 1,
                child: Obx(() => Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item Qty',
                                style: greyTextStyle.copyWith(fontSize: 12.sp),
                              ),
                              Text(
                                cartController.itemQty.value.toString(),
                                style: greyTextStyle.copyWith(fontSize: 12.sp),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                UtilsHelper()
                                    .stringToRupiah(int.tryParse(cartController.totalPriceProduct.toString())!),
                                style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
