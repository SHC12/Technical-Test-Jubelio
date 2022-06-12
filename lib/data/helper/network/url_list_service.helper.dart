class UrlListService {
  static final baseUrl = 'http://api.elevenia.co.id/rest/';

  static String urlProductList(int? pageNumber) => "prodservices/product/listing?page=${pageNumber.toString()}";
  static final urlDelivery = 'delivery/template';
  static String urlDetailProduct(String? prodNo) => "prodservices/product/details/$prodNo";
}
