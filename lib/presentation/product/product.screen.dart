import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/product.controller.dart';

class ProductScreen extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProductScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
