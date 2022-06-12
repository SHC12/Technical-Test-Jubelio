import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';
import 'package:technical_test/data/helper/util/utils.helper.dart';
import 'package:technical_test/data/model/cart_model.dart';
import 'package:technical_test/data/model/product_model.dart';
import 'package:technical_test/presentation/cart/controllers/cart.controller.dart';

class ProductCardWidget extends StatelessWidget {
  final Product item;
  final Function()? onTap;
  const ProductCardWidget({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: item.productDetail!.prdImage01!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 18.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                    height: 18.h,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productDetail!.prdNm!,
                        overflow: TextOverflow.ellipsis,
                        style: defaultTextStyle,
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Terjual: ',
                            style: greyTextStyle,
                          ),
                          Text(item.productDetail!.prdSelQty!.toString(), style: greyTextStyle)
                        ],
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(UtilsHelper().stringToRupiah(int.parse(item.productDetail!.selPrc!.toString())),
                          style: heading1TextStyle),
                      SizedBox(
                        height: 1.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {
                            bool? result = await cartController.addItemToCart(CartModel(product: item, quantity: 1));
                            if (result!) {
                              await UtilsHelper().popUpMessage('Success', context);
                            } else {
                              await UtilsHelper().popUpMessage('Product Already in cart', context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Remix.shopping_cart_2_line,
                                  color: secondaryColor,
                                  size: 15.sp,
                                ),
                                Text(
                                  'Add Cart',
                                  style: defaultTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
