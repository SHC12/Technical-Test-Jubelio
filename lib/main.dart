import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:technical_test/data/model/cart_model.dart';
import 'package:technical_test/data/model/delivery_model.dart';
import 'package:technical_test/data/model/product_detail_model.dart';
import 'package:technical_test/data/model/product_model.dart';
import 'package:technical_test/data/model/product_options_details_model.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ProductDetailAdapter());
  Hive.registerAdapter(DeliveryAdapter());
  Hive.registerAdapter(ProductOptionDetailsAdapter());
  Hive.registerAdapter(CartModelAdapter());

  var initialRoute = await Routes.initialRoute;
  runApp(LayoutBuilder(builder: (context, containr) {
    return Main(initialRoute);
  }));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialRoute: initialRoute,
        getPages: Nav.routes,
        debugShowCheckedModeBanner: false,
        title: "Happy Mart",
      );
    });
  }
}
