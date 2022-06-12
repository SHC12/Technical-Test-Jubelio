import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'package:technical_test/data/helper/network/network.helper.dart';

import 'package:technical_test/data/model/product_model.dart';

import 'package:technical_test/data/service/local/product_local.service.dart';
import 'package:technical_test/data/service/remote/product_impl.service.dart';

class ProductController extends GetxController {
  RxList<Product> productData = <Product>[].obs;

  RxList<Product> searchData = <Product>[].obs;

  NetworkHelper helper = NetworkHelper();

  RxString? key = "".obs;

  RxBool? isLoadMore = false.obs;
  RxBool? isLoading = false.obs;

  Future<List<Product>> fetchProduct(int page, bool isOnline) async {
    isLoading!.value = true;
    List<Product> list = await ProductLocalService().getCacheProduct();
    if (isOnline) {
      List<Product> product = await ProductImplService().getProduct(page);
      list = await ProductLocalService().addCacheProduct(product);
    }

    productData.assignAll(list);
    isLoading!.value = false;
    isLoadMore!.value = false;

    return productData;
  }

  void searchProduct(String? keyword) async {
    key!.value = keyword!;
    isLoading!.value = true;
    if (key == null || key!.value == "") {
      isLoading!.value = false;
    } else {
      searchData.clear();
      for (var product in productData) {
        if (product.prdNm!.toLowerCase().contains(key!.toLowerCase())) {
          searchData.add(product);
        }
      }
      isLoading!(false);
    }
  }

  void fetchMoreProduct(String keywordSearch, int page) async {
    isLoadMore!.value = true;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      fetchProduct(page, true);
    } else {
      fetchProduct(page, false);
    }
  }
}
