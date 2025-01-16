import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart'; // Add this import
import 'package:fseg/Sign.dart';
import 'Menu.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LoginPge());
}

class LoginPge extends StatelessWidget {
  const LoginPge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      routes: {
        // Define the route name for the Menu widget
        '/menu': (context) => Menu(),
      },
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: AndroidSmall5(),
      ),
    );
  }
}

class AndroidSmall5 extends StatefulWidget {
  @override
  _AndroidSmall5State createState() => _AndroidSmall5State();
}

class _AndroidSmall5State extends State<AndroidSmall5> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users');


  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if login is successful
      if (userCredential.user != null) {
        // Login successful, redirect to main page
        final String uid = _auth.currentUser!.uid; // Get the UID

        // Fetch user data from Firebase Realtime Database
        DatabaseEvent snapshot = (await _userRef.child(uid).once()) as DatabaseEvent;

        // Check if user data exists
        if (snapshot.snapshot.value != null) {
          // User data found, extract user details
          Map<dynamic, dynamic>? userData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

          // Check if userData is not null
          if (userData != null) {
            String name = userData['name'];
            String email = userData['email'];
            String number = userData['number'];
            String address = userData['address'];

            // Redirect to main page with user details
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Menu(
                  email: email,
                  name: name,
                  number: number,
                  address: address,
                ),
              ),
            );
          } else {
            // userData is null
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User data is null')),
            );
          }
        } else {
          // User data not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found')),
          );
        }
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 640,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
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


          Positioned(
            left: 30,
            top: 37,
            child: SizedBox(
              width: 289,
              height: 52,
              child: Text(
                'Login',
                textAlign: TextAlign.center,
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
            left: 34,
            top: 160,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                controller: _emailController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Email',
                  prefixIcon: Icon(
                      Icons.email, color: Colors.black.withOpacity(0.5)),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 34,
            top: 250,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(
                      Icons.lock, color: Colors.black.withOpacity(0.5)),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 34,
            top: 444,
            child: Container(
              width: 293,
              height: 47,
              child: ElevatedButton(
                onPressed: () => _signInWithEmailAndPassword(context),
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 34,
            top: 510,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sign()),
                );
                },
              child: Text(
                'Don`t have an account? Sign up',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
