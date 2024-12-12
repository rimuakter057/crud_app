
import 'package:crud_app/models/product.dart';
import 'package:crud_app/ui/screens/Update_Product_Screen/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
     /* leading: Image.network(
        product.image ?? '',
        width: 40,
      ),*/
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? 'Empty'}'),
          Text('Quantity: ${product.quantity ?? 'Empty'}'),
          Text('Price: ${product.unitPrice ?? 'Empty'}'),
          Text('Total Price: ${product.totalPrice ?? 'Empty'}'),
        ],
      ),
      trailing:Wrap(children: [
        IconButton(onPressed: (){},
            icon:const Icon(Icons.delete)),
        IconButton(onPressed: (){
          Navigator.pushNamed(
            context,
            UpdateProductScreen.name,
            arguments: product,
          );
        },
            icon:const Icon(Icons.edit)),
      ],),
    );
  }
}