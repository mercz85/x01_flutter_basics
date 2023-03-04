import 'package:flutter/material.dart';

import 'app_state_scope_widget.dart';
import 'components/products_list.dart';
import 'components/shopping_cart_icon.dart';
import 'constants.dart';
import 'repositories/products_server.dart';
/*
State Management Doc: https://docs.flutter.dev/development/data-and-backend/state-mgmt/options
YT workshop INHERITED WIDGET: https://youtu.be/LFcGPS6cGrY
DartPad workshop base code: https://dartpad.dev/workshops.html?webserver=https://dartpad-workshops-io2021.web.app/inherited_widget&utm_source=google-io21&utm_medium=referral&utm_campaign=io21-resources#Step1
*/

//4. We don´t need GlobalKey shoppingCart or productList anymore
// final GlobalKey<ShoppingCartIconState> shoppingCart =
//     GlobalKey<ShoppingCartIconState>();
//final GlobalKey<ProductListWidgetState> productList =
// GlobalKey<ProductListWidgetState>();

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Store',
//       home: MyStorePage(),
//     ),
//   );
// }

/*
**[InheritedWidget] SUM-UP**

AppStateWidget (stateful)
    child: MyStorePage
    _data (in state)
    setState (functions that change state of data)
    build: AppStateScope
 
AppStateScope INHERITEDWIDGET (data + child) child is the widget we want to pass data (AppState)
    of() returns the AppState
    updateShoudlNotify()
    child: MyStorePage passed from AppStateWidget
  
AppState
    productList
    itemsInCart
    copyWith()
  
To Consume it down the tree at MyStorePage, ProductListWidget, ShoppingCartIcon
    we use methods: AppStateWidget..addToCart
    we get data: AppStateScope..productList
*/

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  MyStorePageState createState() => MyStorePageState();
}

class MyStorePageState extends State<MyStorePage> {
  bool _inSearch = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _toggleSearch() {
    setState(() {
      _inSearch = !_inSearch;
    });

    _controller.clear();
    //productList.currentState!.productList = Server.getProductList();
    AppStateWidget.of(context).setProductList(Server.getProductList());
  }

  void _handleSearch() {
    _focusNode.unfocus();
    final String filter = _controller.text;
    // productList.currentState!.productList = Server.getProductList(filter: filter);
    AppStateWidget.of(context)
        .setProductList(Server.getProductList(filter: filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network('$baseAssetURL/google-logo.png'),
            ),
            title: _inSearch
                ? TextField(
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    autofocus: true,
                    focusNode: _focusNode,
                    controller: _controller,
                    onSubmitted: (_) => _handleSearch(),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      hintText: 'Search Google Store',
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _handleSearch),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _toggleSearch),
                    ),
                  )
                : null,
            actions: [
              if (!_inSearch)
                IconButton(
                  onPressed: _toggleSearch,
                  icon: const Icon(Icons.search, color: Colors.black),
                ),
              ShoppingCartIcon(),
            ],
            backgroundColor: Colors.white,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ProductListWidget(),
          ),
        ],
      ),
    );
  }
}
