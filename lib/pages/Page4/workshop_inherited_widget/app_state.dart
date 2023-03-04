//[InheritedWidget] 1. We create a customized state dataModel for our app
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
