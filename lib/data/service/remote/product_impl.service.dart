import 'package:technical_test/data/helper/network/network.helper.dart';
import 'package:technical_test/data/helper/network/url_list_service.helper.dart';
import 'package:technical_test/data/model/product_model.dart';
import 'package:technical_test/data/model/product_detail_model.dart';
import 'package:xml/xml.dart';

class ProductImplService {
  NetworkHelper helper = NetworkHelper();

  Future<List<Product>> getProduct(int page) async {
    final list = <Product>[];

    await helper.get(
        path: UrlListService.urlProductList(page),
        headers: {
          'Content-Type': 'application/xml',
          'openapikey': '721407f393e84a28593374cc2b347a98',
          'Accept-Charset': 'utf-8'
        },
        onSuccess: (content) async {
          var xmlData = XmlDocument.parse(content);
          var dataProduct = xmlData.findAllElements('product');
          for (var data in dataProduct) {
            String? prodNo = data.findElements('prdNo').isEmpty ? '' : data.findElements('prdNo').first.text;
            getDetailProduct(prodNo).then((value) {
              return;
            });
            ProductDetail detail = await getDetailProduct(prodNo);
            list.add(Product.fromXml(data, detail));
          }

          return list;
        },
        onError: (error) {
          return <Product>[];
        });
    return list;
  }

  Future<ProductDetail> getDetailProduct(String? prodNo) async {
    return helper.get(
        path: UrlListService.urlDetailProduct(prodNo),
        headers: {
          'Content-Type': 'application/xml',
          'openapikey': '721407f393e84a28593374cc2b347a98',
          'Accept-Charset': 'utf-8'
        },
        onSuccess: (detailContent) {
          var xmlData = XmlDocument.parse(detailContent);
          var dataDetailProduct = xmlData.findAllElements('Product');
          var data = ProductDetail.fromXml(dataDetailProduct.single);
          return data;
        },
        onError: (error) {
          return error;
        });
  }
}
