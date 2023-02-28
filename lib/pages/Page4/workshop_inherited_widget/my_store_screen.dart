import 'package:flutter/material.dart';
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

//1. We create a customized state dataModel for our app
class AppState {
  final List<String> productList;
  final Set<String> itemsInCart;

  AppState({
    required this.productList,
    this.itemsInCart = const <String>{},
  });

  //Method to duplicate a state object with a new product list or item in cart.
  // We can use it to Update state
  AppState copyWith({
    List<String>? productList,
    Set<String>? itemsInCart,
  }) {
    return AppState(
      productList: productList ?? this.productList,
      itemsInCart: itemsInCart ?? this.itemsInCart,
    );
  }
}

//2. We implement our InheritedWidget
class AppStateScope extends InheritedWidget {
  final AppState data;

  AppStateScope(
    this.data, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);
  //Method to access the inherited widget
  static AppState of(BuildContext context) {
    //Try to find the same InheritedW with the type you passed and return it to you
    //and it will notify IW that there is a new context to listen to data objects,
    //we need to notify for rebuilds
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  //We check if we should notify listeners
  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}

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

//5. convert ShoppingCartIcon into StatelessWidget
class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //We access our State
    final Set<String> itemsInCart = AppStateScope.of(context).itemsInCart;

    final bool hasPurchase = itemsInCart.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: hasPurchase ? 17.0 : 10.0),
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        if (hasPurchase)
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              child: Text(
                itemsInCart.length.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

//6. convert ProductListWidget into StatelessWidget
class ProductListWidget extends StatelessWidget {
  ProductListWidget({Key? key}) : super(key: key);

  List<String> get productList => _productList;
  List<String> _productList = Server.getProductList();

  void _handleAddToCart(String id, BuildContext context) {
    AppStateWidget.of(context).addToCart(id);
  }

  void _handleRemoveFromCart(String id, BuildContext context) {
    AppStateWidget.of(context).removeFromCart(id);
  }

  Widget _buildProductTile(String id, BuildContext context) {
    return ProductTile(
      product: Server.getProductById(id),
      purchased: AppStateScope.of(context).itemsInCart.contains(id),
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

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.product,
    required this.purchased,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  }) : super(key: key);
  final Product product;
  final bool purchased;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(Set<MaterialState> states) {
      return purchased ? Colors.grey : Colors.black;
    }

    BorderSide getButtonSide(Set<MaterialState> states) {
      return BorderSide(
        color: purchased ? Colors.grey : Colors.black,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 40,
      ),
      color: const Color(0xfff80000), //const Color(0xfff8f8f8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(product.title),
          ),
          Text.rich(
            product.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: OutlinedButton(
              child: purchased
                  ? const Text('Remove from cart')
                  : const Text('Add to cart'),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith(getButtonColor),
                side: MaterialStateProperty.resolveWith(getButtonSide),
              ),
              onPressed: purchased ? onRemoveFromCart : onAddToCart,
            ),
          ),
          Image.network(product.pictureURL),
        ],
      ),
    );
  }
}
// The code below is for the dummy server, and you should not need to modify it
// in this workshop.

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/inherited_widget/assets';

const Map<String, Product> kDummyData = {
  '0': Product(
    id: '0',
    title: 'Explore Pixel phones',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Capture the details.\n',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: 'Capture your world.',
        style: TextStyle(color: Colors.blue),
      ),
    ]),
    pictureURL: '$baseAssetURL/pixels.png',
  ),
  '1': Product(
    id: '1',
    title: 'Nest Audio',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Amazing sound.\n', style: TextStyle(color: Colors.green)),
      TextSpan(text: 'At your command.', style: TextStyle(color: Colors.black)),
    ]),
    pictureURL: '$baseAssetURL/nest.png',
  ),
  '2': Product(
    id: '2',
    title: 'Nest Audio Entertainment packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Built for music.\n',
        style: TextStyle(color: Colors.orange),
      ),
      TextSpan(
        text: 'Made for you.',
        style: TextStyle(color: Colors.black),
      ),
    ]),
    pictureURL: '$baseAssetURL/nest-audio-packages.png',
  ),
  '3': Product(
    id: '3',
    title: 'Nest Home Security packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Your home,\n', style: TextStyle(color: Colors.black)),
      TextSpan(text: 'safe and sound.', style: TextStyle(color: Colors.red)),
    ]),
    pictureURL: '$baseAssetURL/nest-home-packages.png',
  ),
};

class Server {
  static Product getProductById(String id) {
    return kDummyData[id]!;
  }

  static List<String> getProductList({String? filter}) {
    if (filter == null) return kDummyData.keys.toList();
    final List<String> ids = <String>[];
    for (final Product product in kDummyData.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        ids.add(product.id);
      }
    }
    return ids;
  }
}

class Product {
  const Product({
    required this.id,
    required this.pictureURL,
    required this.title,
    required this.description,
  });

  final String id;
  final String pictureURL;
  final String title;
  final TextSpan description;
}
