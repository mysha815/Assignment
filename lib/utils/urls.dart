class Urls {
  static const String _baseurl ='http://35.73.30.144:2008/api/v1';

  static const String getProductList ='$_baseurl/ReadProduct';
  static  String DeleteProductList(String id) =>'$_baseurl/DeleteProduct/$id';


}