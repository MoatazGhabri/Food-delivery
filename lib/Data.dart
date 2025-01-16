import 'package:flutter/material.dart';
import 'CartItem.dart';
import 'Menu.dart';

class Data extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final String? desc;
  const Data({Key? key, required this.name, required this.image, required this.price , this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            AndroidSmall3(
              name: name,
              image: image,
              price: price,
              desc: desc,
            ),
          ],
        ),
      ),
    );
  }
}


class AndroidSmall3 extends StatefulWidget {
  final String name;
  final String image;
  final int price;
  final String? desc ;

  const AndroidSmall3({Key? key, required this.name, required this.image, required this.price,  this.desc}) : super(key: key);

  @override
  _AndroidSmall3State createState() => _AndroidSmall3State();
}

class _AndroidSmall3State extends State<AndroidSmall3> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }
  void addToCart() {
    if (quantity > 0) {
      // Create a CartItem object
      CartItem newItem = CartItem(
        name: widget.name,
        image: widget.image,
        price: widget.price,
        quantity: quantity,
      );
      // Add the item to the cart
      cart.add(newItem);
      // Show a confirmation snack bar or navigate to the confirm page
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(seconds: 2),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.16, -0.99),
              end: Alignment(0.16, 0.99),
              colors: [Color(0xFF482B9C), Color(0x99644AB5)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 294,
                child: Container(
                  width: 360,
                  height: 346,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 526,
                child: GestureDetector(
                  onTap: addToCart,
                  child: Container(
                  width: 200,
                  height: 90,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 185.59,
                          height: 76,
                          decoration: ShapeDecoration(
                            color: Color(0xFF5C42A8),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Color(0xFF4927AF)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 33.74,
                        top: 26,
                        child: SizedBox(
                          width: 152.15,
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Abhaya Libre ExtraBold',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
              Positioned(
                left: 32,
                top: 339,
                child: SizedBox(
                  width: 169,
                  height: 33,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Abril Fatface',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 257,
                top: 339,
                child: SizedBox(
                  width: 83.05,
                  height: 22.03,
                  child: Text(
                    '${widget.price} DT',
                    style: TextStyle(
                      color: Color(0xFFC9AA05),
                      fontSize: 24,
                      fontFamily: 'Abril Fatface',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 275,
                top: 372,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Text(
                    '$quantity', // Display the quantity
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Abril Fatface',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 444,
                child: SizedBox(
                  width: 254,
                  height: 57,
                  child: Text(
                    '${widget.desc}'?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Abhaya Libre ExtraBold',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 247,
                top: 376,
                child: GestureDetector(
                  onTap: decrementQuantity,
                  child: Container(
                    width: 15.74,
                    height: 15.27,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 299,
                top: 376,
                child: GestureDetector(
                  onTap: incrementQuantity,
                  child: Container(
                    width: 15.74,
                    height: 15.27,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 62,
                child: Container(
                  width: 198.56,
                  height: 188,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Menu(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}
