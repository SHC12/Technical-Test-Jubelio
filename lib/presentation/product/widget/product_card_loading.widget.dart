import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:technical_test/presentation/shared/shimmer_widget.dart';

class ProductCardLoadingWidget extends StatelessWidget {
  const ProductCardLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
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
              ShimmerWidget(height: 18.h, width: 100.w),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(
                      height: 12.sp,
                      width: 100.w,
                    ),
                    SizedBox(height: 1.5.h),
                    ShimmerWidget(
                      height: 12.sp,
                      width: 30.w,
                    ),
                    SizedBox(height: 1.5.h),
                    ShimmerWidget(
                      height: 12.sp,
                      width: 50.w,
                    ),
                    SizedBox(height: 1.5.h),
                    ShimmerWidget(
                      height: 12.sp,
                      width: 100.w,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
