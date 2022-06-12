import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

import 'package:sizer/sizer.dart';
import 'package:technical_test/app/config/app_colors.dart';
import 'package:technical_test/app/config/app_text_styles.dart';
import 'package:technical_test/data/helper/util/utils.helper.dart';
import 'package:technical_test/data/model/cart_model.dart';
import 'package:technical_test/data/model/product_model.dart';
import 'package:technical_test/data/model/product_detail_model.dart';
import 'package:technical_test/presentation/cart/controllers/cart.controller.dart';
import 'package:technical_test/presentation/cart/widget/cart_icon.widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? _currentIndex = 0;
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductDetail dataProductDetail = widget.product.productDetail!;
    List<String?> imageList = [
      dataProductDetail.prdImage01,
      dataProductDetail.prdImage02,
      dataProductDetail.prdImage03,
      dataProductDetail.prdImage04,
    ];
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
            top: false,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
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
                          'Details',
                          style: heading1TextStyle,
                        ),
                        CartIconWidget()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        height: 300.0,
                        viewportFraction: 1),
                    items: imageList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: i!,
                              imageBuilder: (context, imageProvider) => Container(
                                width: 200,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
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
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  widget.product.productDetail!.prdNm!,
                                  maxLines: 5,
                                  style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Description',
                            style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Html(
                            data: dataProductDetail.htmlDetail!,
                            shrinkWrap: true,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: ',
                                    style: defaultTextStyle,
                                  ),
                                  Text(
                                    UtilsHelper()
                                        .stringToRupiah(int.parse(widget.product.productDetail!.selPrc!.toString())),
                                    style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool? result = await cartController
                                      .addItemToCart(CartModel(product: widget.product, quantity: 1));
                                  if (result!) {
                                    await UtilsHelper().popUpMessage('Success', context);
                                  } else {
                                    await UtilsHelper().popUpMessage('Product Already in cart', context);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Add Cart',
                                        style: defaultTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
