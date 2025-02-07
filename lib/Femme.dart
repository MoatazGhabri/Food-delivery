import 'package:flutter/material.dart';

void main() {
  runApp(const Product());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          AndroidSmall3(),
        ]),
      ),
    );
  }
}

class AndroidSmall3 extends StatelessWidget {
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
              Positioned(
                left: 32,
                top: 339,
                child: SizedBox(
                  width: 169,
                  height: 33,
                  child: Text(
                    'Beef Burger',
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
                    '16 DT',
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
                    '0',
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
                    'Big juisy beef burger with cheese',
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
                left: 242,
                top: 373,
                child: Container(
                  width: 28.74,
                  height: 27.27,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(children: [

                      ]),
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
                      image: NetworkImage("https://via.placeholder.com/199x188"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}