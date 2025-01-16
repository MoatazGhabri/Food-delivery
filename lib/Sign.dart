import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fseg/LoginPge.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Sign());
}

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
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

class AndroidSmall5 extends StatelessWidget {
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users'); // Reference to 'users' node
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
            left: 30,
            top: 37,
            child: SizedBox(
              width: 289,
              height: 52,
              child: Text(
                'Create account',
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
            top: 89,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Name',
                  prefixIcon: Icon(
                      Icons.person, color: Colors.black.withOpacity(0.5)),
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
            top: 231,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                controller: _numberController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Number',
                  prefixIcon: Icon(
                      Icons.phone, color: Colors.black.withOpacity(0.5)),
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
            top: 302,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                controller: _addressController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Address',
                  prefixIcon: Icon(
                      Icons.home, color: Colors.black.withOpacity(0.5)),
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
            top: 373,
            child: Container(
              width: 293,
              height: 47,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
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
              child: TextField(
                obscureText: true,
                controller: _confirmPasswordController,

                style: TextStyle(
                  color: Colors.black,
                ),

                decoration: InputDecoration(

                  filled: true,
                  fillColor: Color(0xFFD9D9D9),

                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Confirm Password',
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
            top: 510,
            child: Container(
              width: 293,
              height: 47,
              child: ElevatedButton(
                onPressed: () {
                  _signUp(context);
                },
                child: Text('Sign Up'),
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
            top: 570,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPge()),
                );              },
              child: Text(
                'Already have an account? Sign in',
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


  Future<void> _signUp(BuildContext context) async {
    // Get the user data from the text fields
    String name = _nameController.text;
    String email = _emailController.text;
    String number = _numberController.text;
    String address = _addressController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if password and confirm password match
    if (password != confirmPassword) {
      // Show notification if passwords don't match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return; // Exit the method
    }

    try {
      // Create user with email and password using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the Firebase User object
      User? user = userCredential.user;

      // Check if user is null
      if (user != null) {
        // User creation successful, store additional data in Firebase Realtime Database
        await _userRef.child(user.uid).set({
          'name': name,
          'email': email,
          'number': number,
          'address': address,
        });

        // Sign-up successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up successful')),
        );
      }
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

}