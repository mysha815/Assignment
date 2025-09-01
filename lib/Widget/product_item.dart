
import 'package:crudapp_project/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../module_13/UpdateProductScreen.dart';
import '../utils/urls.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key, required this.product, required this.refreshproductList
  });
  final  ProductModel product;
  final VoidCallback refreshproductList;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _deleteInProgress = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 70,
        width: 70,
        child: Image.network(
          widget.product.image,
          errorBuilder: (_,__,___){
            return Icon(Icons.error_outline);
          },
        ),
      ),
      title: Text(widget.product.name,style: TextStyle(fontSize: 20),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code :${widget.product.code}'),
          Row(
            children: [
              Text('Quantity :${widget.product.quantity}',style: TextStyle(fontSize: 16),),
              SizedBox(width: 10,),
              Text('Unit :${widget.product.unitPrice}'),
            ],
          ),


        ],
      ),
      trailing: Visibility(
        visible: _deleteInProgress == false,
        replacement: CircularProgressIndicator(),
        child: PopupMenuButton<ProductOptions>(
          itemBuilder:(context) {
            return[
              PopupMenuItem(
                value: ProductOptions.update,
                child: Text('Update'),
              ),
              PopupMenuItem(
                value: ProductOptions.delete,
                child: Text('Delete'),
              ),
            ];
          },
          onSelected: (ProductOptions selesctedOption){
            if (selesctedOption == ProductOptions.delete){
              _deleteProduct();
            }else if (selesctedOption == ProductOptions.update){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateProductScreen(
                product: widget.product,

              )
              )
              ).then((needRefresh){
                debugPrint('updated:$needRefresh');
                if(needRefresh == true){
                  widget.refreshproductList();
                }
              });
            }
          },
        ),
      ),
    );
  }

  Future<void> _deleteProduct() async{
    _deleteInProgress = true;
    setState(() {

    });

    Uri uri =Uri.parse(Urls.DeleteProductList(widget.product.id));
    Response response = await get(uri);
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if(response.statusCode == 200){
      widget.refreshproductList();

      }
    _deleteInProgress = false;
    setState(() {

    });
    }
}


enum ProductOptions{
  update,
  delete
}