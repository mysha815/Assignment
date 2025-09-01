import 'dart:convert';

import 'package:crudapp_project/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Widget/product_item.dart';
import '../models/product_model.dart';
import 'AddNewProductScreen.dart';
import 'UpdateProductScreen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final List<ProductModel> _productList = [];
  bool _getProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Future<void> _getProductList() async {
    _productList.clear();
    _getProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.getProductList);
    Response response = await get(uri);
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 200) {
      final decodedjson = jsonDecode(response.body);
      for (Map<String, dynamic> productjson in decodedjson['data']) {
        ProductModel productModel = ProductModel.fromjson(productjson);
        _productList.add(productModel);
      }
    }

    _getProductInProgress = false;

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                _getProductList();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Visibility(
        visible: _getProductInProgress == false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: _productList[index],
              refreshproductList: () {
                _getProductList();
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              indent: 70,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewProductScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
