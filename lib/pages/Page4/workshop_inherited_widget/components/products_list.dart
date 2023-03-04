import 'package:flutter/material.dart';

import '../app_state_scope.dart';
import '../app_state_scope_widget.dart';
import '../repositories/products_server.dart';
import 'product_tile.dart';

//[InheritedWidget] 6. convert ProductListWidget into StatelessWidget
class ProductListWidget extends StatelessWidget {
  ProductListWidget({Key? key}) : super(key: key);

  List<String> get productList => _productList;
  List<String> _productList = Server.getProductList();

  //Callbacks to pass to our ProctTile
  void _handleAddToCart(String id, BuildContext context) {
    AppStateWidget.of(context).addToCart(id); //[InheritedWidget]
  }

  void _handleRemoveFromCart(String id, BuildContext context) {
    AppStateWidget.of(context).removeFromCart(id); //[InheritedWidget]
  }

  Widget _buildProductTile(String id, BuildContext context) {
    return ProductTile(
      product: Server.getProductById(id),
      purchased: AppStateScope.of(context)
          .itemsInCart
          .contains(id), //[InheritedWidget]
      onAddToCart: () => _handleAddToCart(id, context),
      onRemoveFromCart: () => _handleRemoveFromCart(id, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppStateScope.of(context)
          .productList
          .map((String id) => _buildProductTile(id, context))
          .toList(),
    );
  }
}
