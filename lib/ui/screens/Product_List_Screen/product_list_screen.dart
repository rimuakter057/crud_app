import 'dart:convert';

import 'package:crud_app/ui/screens/Add_Product_Screen/add_product_screen.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../widgets/product_item.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;
  @override
  void initState() {
    _getProductList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("product list"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AddProductScreen.name);
      },
      child: const Icon(Icons.add,color: Colors.black,),),
      body: RefreshIndicator(
        onRefresh: () async{
          _getProductList();
        },
        child: Visibility(
          visible: _inProgress == false,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context,index){
            return ProductItem(
              product: productList[index],);
          }),
        ),
      ),
    );
  }
  Future  <void> _getProductList()async{
    productList.clear();
    _inProgress = true;
    setState(() {

    });
    Uri url = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response =await get(url);
    print(response.statusCode);
    if(response.statusCode==200){
      final decodedData= jsonDecode(response.body);
      for(Map<String,dynamic> p in decodedData['data']){
        Product product = Product(
          id: p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          quantity: p['Qty'],
          unitPrice: p['UnitPrice'],
          image: p['Img'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate'],
        );
        productList.add(product);
      }
      _inProgress = false;
      setState(() {

      });
    }else {
      print("error");
    }

}

}



