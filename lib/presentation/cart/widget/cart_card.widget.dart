import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';
import 'package:technical_test/data/helper/util/utils.helper.dart';
import 'package:technical_test/data/model/cart_model.dart';
import 'package:technical_test/presentation/cart/controllers/cart.controller.dart';

class CartCardWidget extends StatefulWidget {
  final CartModel cart;
  CartCardWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      height: 15.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: widget.cart.product!.productDetail!.prdImage01!,
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                height: 160,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                    value: downloadProgress.progress,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/image/image_not_found.jpeg',
                height: 160,
                width: 200,
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.cart.product!.prdNm!,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      UtilsHelper().stringToRupiah(int.tryParse(widget.cart.product!.selPrc!)!),
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {});
                                cartController.decreaseQuantityItemCart(widget.cart);
                              },
                              child: Icon(Remix.indeterminate_circle_line)),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            widget.cart.quantity.toString(),
                            style: defaultTextStyle,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {});
                                cartController.increaseQuantityItemCart(widget.cart);
                              },
                              child: Icon(Remix.add_circle_line)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
