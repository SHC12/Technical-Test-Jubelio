import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/presentation/cart/cart.screen.dart';
import 'package:technical_test/presentation/cart/controllers/cart.controller.dart';

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({Key? key}) : super(key: key);

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CartScreen());
      },
      child: Obx(() => Badge(
            badgeContent: Text(cartController.cartList.length.toString()),
            animationType: BadgeAnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            badgeColor: primaryColor,
            position: BadgePosition.topStart(
              top: -10,
            ),
            child: Icon(
              Remix.shopping_cart_2_line,
            ),
          )),
    );
  }
}
