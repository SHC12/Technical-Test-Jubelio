import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:technical_test/data/model/cart_model.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList = <CartModel>[].obs;

  RxInt? totalPriceProduct = 0.obs;
  RxInt itemQty = 0.obs;
  RxInt total = 0.obs;

  RxBool? isLoading = false.obs;
  Future<List<CartModel>> getCart() async {
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');

    if (data != null) {
      List<CartModel> result = (data as Iterable).map<CartModel>((i) => i).toList();
      cartList.assignAll(result);
      for (var element in result) {
        totalPriceProduct!.value += (int.parse(element.product!.selPrc!) * element.quantity!);
      }
    }
    itemQty.value = cartList.fold(0, (previousValue, element) => previousValue + element.quantity!);

    isLoading!(false);
    return cartList;
  }

  Future<bool?> addItemToCart(CartModel? cart) async {
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');
    List<CartModel> cartList = <CartModel>[];
    if (data != null) {
      List<CartModel> result = (data as Iterable).map<CartModel>((i) => i).toList();
      if (result.where((element) => element.product!.prdNo == cart!.product!.prdNo).isEmpty) {
        result.add(cart!);
        box.put('carts', result);
        getCart();

        return true;
      } else {
        return false;
      }
    } else {
      cartList.add(cart!);
      box.put('carts', cartList);
      getCart();

      return true;
    }
  }

  void increaseQuantityItemCart(CartModel? cart) async {
    totalPriceProduct!.value = 0;
    cartList.singleWhere((element) => element == cart).quantity =
        cartList.singleWhere((element) => element == cart).quantity! + 1;
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');
    List<CartModel> result = (data as Iterable).map<CartModel>((i) => i).toList();

    result.assignAll(cartList);
    box.put('carts', result);
    getCart();
  }

  void decreaseQuantityItemCart(CartModel? cart) async {
    totalPriceProduct!.value = 0;
    cartList.singleWhere((element) => element == cart).quantity =
        cartList.singleWhere((element) => element == cart).quantity! - 1;
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');
    List<CartModel> result = (data as Iterable).map<CartModel>((i) => i).toList();

    result.assignAll(cartList);
    box.put('carts', result);
    getCart();
  }
}
