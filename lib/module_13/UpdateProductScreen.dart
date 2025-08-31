import 'dart:convert';

import 'package:crudapp_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Widget/snackber_message.dart';
class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool _updateProductInProgress = false;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _CodeTEController = TextEditingController();
  final TextEditingController _QuantityTEController = TextEditingController();
  final TextEditingController _PriceTEController = TextEditingController();
  final TextEditingController _ImageUrlTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.name;
    _CodeTEController.text = widget.product.code.toString();
    _QuantityTEController.text = widget.product.quantity.toString();
    _PriceTEController.text = widget.product.unitPrice.toString();
    _ImageUrlTEController.text = widget.product.image;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update product'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _fromKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Product name',
                        labelText: 'Product name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty?? true){
                        return 'Enter your value';
                      }
                      return  null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: _CodeTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Product Code',
                        labelText: 'Product Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty?? true){
                        return 'Enter your value';
                      }
                      return  null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: _QuantityTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Product Quantity',
                        labelText: 'Product Quantity',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty?? true){
                        return 'Enter your value';
                      }
                      return  null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: _PriceTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Unit price',
                        labelText: 'Unit price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty?? true){
                        return 'Enter your value';
                      }
                      return  null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: _ImageUrlTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Image Url',
                        labelText: 'Image Url',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty?? true){
                        return 'Enter your value';
                      }
                      return  null;
                    },
                  ),

                  SizedBox(height: 10,),

                  SizedBox(
                    height: 30,
                    child: Visibility(
                      visible: _updateProductInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: FilledButton(onPressed: (){
                         _updateProduct();
                      },

                          child:Text('Update product') ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  Future<void>_updateProduct()async{
    if (_fromKey.currentState!.validate() == false){
      return ;
    }
    _updateProductInProgress = true;
    setState(() {

    });
    Uri uri = Uri.parse('http://35.73.30.144:2008/api/v1/UpdateProduct/65abe919f68794d36c5b7ffa');

    int totalprice = int.parse(_PriceTEController.text)* int.parse(_QuantityTEController.text);
    Map<String,dynamic> requestBody ={
      "ProductName": _nameTEController.text,
      "ProductCode": _CodeTEController.text,
      "Img": _ImageUrlTEController.text,
      "Qty": _QuantityTEController.text,
      "UnitPrice": _PriceTEController.text,
      "TotalPrice": totalprice
    };

    Response response =await post(uri,
        headers: {
          'Content-Type' :'application/json'

        },
        body: jsonEncode(requestBody));
    print(response.statusCode);


    if (response.statusCode == 200){
      final decoddenjson =  jsonDecode(response.body);
      if (decoddenjson['status']== 'success'){

        showSnackBarMessage(context,'Product updated Successfully');
        Navigator.pop(context,true);
      }else{
        String  errorMessage = decoddenjson['data'];
        showSnackBarMessage( context,errorMessage);
      }
    }
    print(response.body);
    _updateProductInProgress = false;
    setState(() {
    });
  }


  @override
  void dispose() {
    _nameTEController.dispose();
    _ImageUrlTEController.dispose();
    _PriceTEController.dispose();
    _QuantityTEController.dispose();
    _CodeTEController.dispose();
    super.dispose();
  }


  }


