import 'package:crud_app/ui/screens/Add_Product_Screen/add_product_screen.dart';
import 'package:crud_app/ui/screens/Product_List_Screen/product_list_screen.dart';
import 'package:crud_app/ui/screens/Update_Product_Screen/update_product_screen.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

class CRUDApp extends StatelessWidget {
  const CRUDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/' ,
      onGenerateRoute: (RouteSettings setting){
        late Widget widget;
      if (setting.name == '/'){
        widget = ProductListScreen();
      }else if (setting.name == AddProductScreen.name){
        widget=AddProductScreen();
      }else if (setting.name == UpdateProductScreen.name){
        final product = setting.arguments as Product;
        widget=UpdateProductScreen(product: product,);
      }
      return MaterialPageRoute(builder: (context){
        return widget;
      });
      },

    
    );
  }
}
