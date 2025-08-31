class ProductModel {
  late String id;
  late String name;
  late int code;
  late String image;
  late int quantity;
  late int unitPrice;
  late int totalPrice;

  ProductModel.fromjson(Map<String,dynamic> productjson){
    id = productjson['_id'];
  name = productjson['ProductName'];
    code = productjson['ProductCode'];
   image = productjson['Img'];
   quantity = productjson['Qty'];
    unitPrice = productjson['UnitPrice'];
   totalPrice = productjson['TotalPrice'];
  }

}