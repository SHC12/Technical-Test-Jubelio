import 'package:hive/hive.dart';
import 'package:technical_test/data/model/product_detail_model.dart';

import 'package:xml/xml.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product {
  Product({
    this.productDetail,
    this.prdNm,
    this.prdNo,
    this.prdSelQty,
    this.selPrc,
    this.dscPrice,
    this.freeDelivery,
    this.stock,
  });
  @HiveField(0)
  ProductDetail? productDetail;
  @HiveField(1)
  String? prdNm;
  @HiveField(2)
  String? prdNo;
  @HiveField(3)
  String? prdSelQty;
  @HiveField(4)
  String? selPrc;
  @HiveField(5)
  String? tmpltSeq;
  @HiveField(6)
  String? dscPrice;
  @HiveField(7)
  String? freeDelivery;

  @HiveField(8)
  String? stock;

  Product.fromXml(XmlElement e, ProductDetail detailProd) {
    dscPrice = e.findElements('dscPrice').isEmpty ? '' : e.findElements('dscPrice').first.text;

    freeDelivery = e.findElements('freeDelivery').isEmpty ? '' : e.findElements('freeDelivery').first.text;

    prdNm = e.findElements('prdNm').isEmpty ? '' : e.findElements('prdNm').first.text;
    prdNo = e.findElements('prdNo').isEmpty ? '' : e.findElements('prdNo').first.text;
    prdSelQty = e.findElements('prdSelQty').isEmpty ? '' : e.findElements('prdSelQty').first.text;

    selPrc = e.findElements('selPrc').isEmpty ? '' : e.findElements('selPrc').first.text;

    stock = e.findElements('stock').isEmpty ? '' : e.findElements('stock').first.text;
    tmpltSeq = e.findElements('tmpltSeq').isEmpty ? '' : e.findElements('tmpltSeq').first.text;

    productDetail = detailProd;
  }

  Product.fromJson(Map<String, dynamic> json) {
    dscPrice = json['dscPrice'];
    freeDelivery = json['freeDelivery'];
    prdNm = json['prdNm'];
    prdNo = json['prdNo'];
    prdSelQty = json['prdSelQty'];
    selPrc = json['selPrc'];
    stock = json['stock'];
    tmpltSeq = json['tmpltSeq'];
    productDetail = ProductDetail.fromJson(json['detailProduct']);
  }
}
