import 'package:flutter/material.dart';
import 'LoginPge.dart';
import 'Menu.dart';
import 'UserDataField.dart';
void main() {
  runApp(const AccountPage());
}

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key,this.email, this.name, this.address, this.number}) : super(key: key);
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
        body: ListView(
          children: [
            AndroidSmall3(email: email, name: name , address: address, number: number),
          ],
        ),
      ),
    );
  }
}

class AndroidSmall3 extends StatefulWidget {
  String? email; // Declare userEmail parameter
  String? name;
  String? address;
  String? number;
  AndroidSmall3({Key? key, this.email, this.name , this.address , this.number}) : super(key: key);
  @override
  _AndroidSmall3State createState() => _AndroidSmall3State();
}

class _AndroidSmall3State extends State<AndroidSmall3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF000235)),
          child: Stack(
            children: [

              // User Avatar
              Positioned(
                left: 150,
                top: 20,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxoVYK9gVqDWkfv3blKuxWEO0t9JrH6XSjxg&s"),
                ),
              ),

              // User Data Fields

              Positioned(
                left: 48,
                top: 164,
                child: UserDataField(
                  label: 'Name',
                  value: widget.name ?? 'Name',
                ),
              ),
              Positioned(
                left: 48,
                top: 228,
                child: UserDataField(
                  label: 'Email',
                  value: widget.email ?? 'Email',
                ),
              ),
              Positioned(
                left: 48,
                top: 292,
                child: UserDataField(
                  label: 'Number',
                  value: widget.number ?? 'Number',
                ),
              ),
              Positioned(
                left: 48,
                top: 356,
                child: UserDataField(
                  label: 'Address',
                  value: widget.address ?? 'Address',
                ),
              ),

              // Existing widgets...

              // Sign Up Button
              Positioned(
                left: 111,
                top: 456,
                child: Container(
                  width: 139,
                  height: 43,
                  child: Stack(
                    children: [
                      // Button widget...
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 12,
                top: 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);

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
