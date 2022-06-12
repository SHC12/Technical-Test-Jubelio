import 'package:flutter/material.dart';

import 'package:technical_test/presentation/product/widget/product_card_loading.widget.dart';

class HomeLoadingCardWidget extends StatelessWidget {
  const HomeLoadingCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        initialItemCount: 10,
        itemBuilder: (context, index, animation) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.58,
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (ctx, i) => const ProductCardLoadingWidget());
        });
  }
}
