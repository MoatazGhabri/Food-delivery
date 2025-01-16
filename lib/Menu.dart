import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fseg/AuthUtils.dart';
import 'package:fseg/Pizza.dart';
import 'AccountPage.dart';
import 'Burger.dart';
import 'Data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Sign.dart';
import 'confirm.dart';
import 'firebase_options.dart';
import 'package:fseg/LoginPge.dart';

import 'main.dart';
void main() async {
  runApp(const Menu());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

class Menu extends StatelessWidget {
  const Menu({Key? key, this.email, this.name, this.address, this.number}) : super(key: key);

  final String? email;
  final String? name;
  final String? address;
  final String? number;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: AndroidSmall2(email: email, name: name , address: address, number: number), // Pass userEmail to AndroidSmall2
      ),
    );
  }
}


class AndroidSmall2 extends StatefulWidget {
   String? email; // Declare userEmail parameter
  String? name;
  String? address;
  String? number;
   AndroidSmall2({Key? key, this.email, this.name , this.address , this.number}) : super(key: key);
  @override
  _AndroidSmall2State createState() => _AndroidSmall2State();
}

class _AndroidSmall2State extends State<AndroidSmall2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _controller = TextEditingController();
  String _searchText = '';
  List<Map<String, dynamic>> _foods = [];
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users');



  @override
  void initState() {
    super.initState();
    getFoods();
    loggedin(); // Call the loggedin method when the widget initializes

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<void> loggedin() async {
    // Check if user is logged in
    User? user = _auth.currentUser;
    if (user != null) {
      // If user is logged in, retrieve user data
      String uid = user.uid;
      DatabaseEvent snapshot = (await _userRef.child(uid).once()) as DatabaseEvent; // Use DataSnapshot instead of DatabaseEvent
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> userData = snapshot.snapshot.value as Map<dynamic, dynamic>; // Cast value to Map<dynamic, dynamic>
        // Set user data to the UI elements
        setState(() {
          widget.email = userData['email'];
          widget.name = userData['name'];
          widget.number = userData['number'];
          widget.address = userData['address'];
        });
      }
    }
  }

  Future<void> getFoods() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final foodsReference = databaseReference.child('foods');
    await foodsReference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _foods = List<Map<String, dynamic>>.from(data.values);
        });
      }
    });
  }
  Future<void> _signOut() async {
    try {
      await _auth.signOut(); // Sign out the current user
      // Redirect to the login page or any other page you prefer
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Menu()), // Replace LoginPge with your login page
            (route) => false,
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: 360,
              height: 640,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                  children: [
              Positioned(
                left: 21,
                top: 72,
                child: Container(
                  width: 319,
                  height: 122,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 88.52,
                          height: 82.51,
                          decoration: ShapeDecoration(
                            color: Color(0xE8593EAB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 115.53,
                        top: 0,

                        child: Container(
                          width: 88.52,
                          height: 82.51,
                          decoration: ShapeDecoration(
                            color: Color(0x77D9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 230.48,
                        top: 0,
                        child: Container(
                          width: 88.52,
                          height: 82.51,
                          decoration: ShapeDecoration(
                            color: Color(0x77D9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 2.87,
                        top: 0,
                        child: Container(
                          width: 83.34,
                          height: 80.74,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/food.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 117.43,
                        top: 4.13,
                        child: MaterialButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Burger(
                                  email: widget.email,
                                  name: widget.name,
                                  address: widget.address,
                                  number: widget.number,
                                ),
                              ),
                            );
                          },
                        child: Container(
                          width: 71.85,
                          height: 72.49,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/burger.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      ),
                      Positioned(
                        left: 230.11,
                        top: 5.89,
                        child: MaterialButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pizza(),
                              ),
                            );
                          },
                        child: Container(
                          width: 71.85,
                          height: 72.49,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/pizza.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        ),
                      ),
                      Positioned(
                        left: 25.86,
                        top: 95.96,
                        child: SizedBox(
                          width: 62.65,
                          height: 21.22,
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Aclonica',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 127.03,
                        top: 95.96,
                        child: SizedBox(
                          width: 93.99,
                          height: 30.86,
                          child: Text(
                            'Burger',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Aclonica',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 241.98,
                        top: 95.96,
                        child: SizedBox(
                          width: 65.52,
                          height: 21.22,
                          child: Text(
                            'Pizza',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Aclonica',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 210,
                child: Container(
                  width: 321,
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 321,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Color(0xA5D9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          width: 300,
                          height: 40,
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(0.5),
                                size: 25,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 22,
                child: SizedBox(
                  width: 252,
                  height: 70,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Aclonica',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 18,
                top: 298,
                child: SizedBox(
                  width: 252,
                  height: 70,
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Aclonica',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
                    Positioned(
                      left: 0,
                      top: 344,
                      child: SizedBox(
                        width: 360,
                        height: 200,
                        child: ListWheelScrollView(
                          itemExtent: 200, // Adjust as needed
                          physics: FixedExtentScrollPhysics(),
                          children: _foods.map((food) {
                            return Container(
                              width: 201,
                              height: 194,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 201,
                                    height: 194,
                                    decoration: ShapeDecoration(
                                      color: Color(0x7CD9D9D9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 32.78,
                                    top: 22.74,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Data(
                                              name: food['name'],
                                              image: food['image'],
                                              price: food['price'],
                                              desc: food['desc'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 87.41,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(food['image']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 118.67,
                                    child: SizedBox(
                                      width: 141,
                                      height: 32.69,
                                      child: Text(
                                        food['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Abril Fatface',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 14.57,
                                    top: 155.63,
                                    child: SizedBox(
                                      width: 83.05,
                                      height: 22.03,
                                      child: Text(
                                        '${food['price']} DT',
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
                                    left: 150.19,
                                    top: 148.52,
                                    child: Container(
                                      width: 34.24,
                                      height: 34.82,
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              Positioned(
                left: 0,
                top: 569,
                child: Container(
                  width: 360,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 578,
                child: Container(
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                    Positioned(
                      left: 208,
                      top: 578,
                      child: GestureDetector(
                        onTap: () {
                          if (_auth.currentUser != null) {
                            // If user is logged in, navigate to the account page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AccountPage(
                                email: widget.email,
                                name: widget.name,
                                address: widget.address,
                                number: widget.number,)),
                            );
                          } else {
                            // If user is not logged in, navigate to the sign-in page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Sign()),
                            );
                          }
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 296,
                      top: 578,
                      child: GestureDetector(
                        onTap: () {
                          _signOut(); // Call _signOut method when logout icon is tapped
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 116,
                      top: 578,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FigmaToCodeApp(
                              email: widget.email,
                              name: widget.name,
                              address: widget.address,
                              number: widget.number,
                            )),
                          );
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],

          ),
        ),
      ],
        )
    );
  }
}
