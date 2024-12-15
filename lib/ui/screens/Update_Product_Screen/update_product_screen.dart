import 'dart:convert';

import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Product_List_Screen/product_list_screen.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;
  const UpdateProductScreen({super.key, required this.product});
  static String name = "/update-product-screen";

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController =
  TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool    _updateProductInProgress = false;
  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _buildProductForm(
              _formKey,
              _nameTEController,
              _priceTEController,
              _totalPriceTEController,
              _quantityTEController,
              _codeTEController,
              _imageTEController,
              _updateProductInProgress),
        ),
      ),
    );
  }

  Widget _buildProductForm(
      GlobalKey<FormState> formKey,
      TextEditingController nameTEController,
      TextEditingController priceTEController,
      TextEditingController totalPriceTEController,
      TextEditingController quantityTEController,
      TextEditingController codeTEController,
      TextEditingController imageTEController,
      bool addNewProductInProgress) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameTEController,
            decoration: const InputDecoration(
                hintText: 'Name', labelText: 'Product name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: priceTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Price', labelText: 'Product Price'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: totalPriceTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Total price', labelText: 'Product Total Price'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product total price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: quantityTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Quantity', labelText: 'Product Quantity'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product quantity';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: codeTEController,
            decoration: const InputDecoration(
                hintText: 'Code', labelText: 'Product Code'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product code';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: imageTEController,
            decoration: const InputDecoration(
                hintText: 'Image url', labelText: 'Product Image'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product image url';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: addNewProductInProgress == false,
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
                  if (formKey.currentState!.validate()) {
                    _updateProduct();
                    print("Update Product");
                    Navigator.pushNamed(context, ProductListScreen.name);
                  }
                  else if (formKey.currentState!.validate() == false) {
                    print("error");
                  }
                },
                child: const Text('Update Product',style: TextStyle(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> requestBody = {
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
    print(response.statusCode);
    print(response.body);
    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been updated!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product update failed! Try again.'),
        ),
      );
    }
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
