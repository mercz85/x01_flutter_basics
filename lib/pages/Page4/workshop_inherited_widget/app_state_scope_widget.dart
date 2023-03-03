import 'package:flutter/material.dart';

import 'app_state.dart';
import 'app_state_scope.dart';
import 'repositories/products_server.dart';

//[InheritedWidget] we wrap our MyStorePage with AppStateWidget that is a widget to manage state
//3. We need to wrap our InheritedW with a StatefulWidget to modify state
class AppStateWidget extends StatefulWidget {
  AppStateWidget({required this.child});

  final Widget child;
  //Method to have access to this API
  static AppStateWidgetState of(BuildContext context) {
    //Try to find the same InheritedW with the type you passed and return it to you
    //but it WONT'T notify the subtree about any change
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState(
    productList: Server.getProductList(),
  );

  void setProductList(List<String> newProductList) {
    if (_data.productList != newProductList) {
      setState(() {
        _data = _data.copyWith(productList: newProductList);
      });
    }
  }

  void addToCart(String id) {
    if (!_data.itemsInCart.contains(id)) {
      setState(() {
        //we create a new object to avoid them to share the same reference
        final Set<String> newItemsInCart = Set<String>.from(_data.itemsInCart);
        newItemsInCart.add(id);
        _data = _data.copyWith(itemsInCart: newItemsInCart);
      });
    }
  }

  void removeFromCart(String id) {
    if (_data.itemsInCart.contains(id)) {
      setState(() {
        //we create a new object to avoid them to share the same reference
        final Set<String> newItemsInCart = Set<String>.from(_data.itemsInCart);
        newItemsInCart.remove(id);
        _data = _data.copyWith(itemsInCart: newItemsInCart);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(_data, child: widget.child);
  }
}
