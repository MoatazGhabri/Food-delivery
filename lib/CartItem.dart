List<CartItem> cart = [];

class CartItem {
  final String name;
  final String image;
  final int price;
  final int quantity;

  CartItem({required this.name, required this.image, required this.price, required this.quantity});

}
