import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Product_List_Screen/product_list_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static String name = "/add-product-screen";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  void initState() {
    _addProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _buildProductForm(),
        ),
      ),
    );
  }

  Form _buildProductForm() {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name', labelText: 'Product name'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price', labelText: 'Product Price'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalPriceTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Total price',
                    labelText: 'Product Total Price'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product total price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Quantity', labelText: 'Product Quantity'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeTEController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Code', labelText: 'Product Code'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageTEController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                    hintText: 'Image url', labelText: 'Product Image'),
                validator: (String? value) {
                  if (value
                      ?.trim()
                      .isEmpty ?? true) {
                    return 'Enter product image url';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: _addNewProductInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height*.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addProduct();
                        print("add product");
                        Navigator.pushNamed(context, ProductListScreen.name);
                      }
                      else  {
                        print("error");
                      }
                    },
                    child: const Text('Add Product',style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
        );
  }

 Future<void> _addProduct()async{
   _addNewProductInProgress = false;
   setState(() {});
   Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
   Map <String,dynamic> requestBody ={
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };
   Response response = await post(
     uri,
     headers: {'Content-type': 'application/json'},
     body: jsonEncode(requestBody),
   );
   _addNewProductInProgress = false;
   setState(() {});
 if (response.statusCode ==200){
   _clearTextFields();
   ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
         content: Text('Added new product!'),
       )
   );
 }else{
   ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
         content: Text('Not added new product!'),
       )
   );
 }
 }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _priceTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();
    _quantityTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}
