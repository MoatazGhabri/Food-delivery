import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Admin"), // Placeholder for admin name
              currentAccountPicture: CircleAvatar(
                // Placeholder for admin avatar
                backgroundImage: NetworkImage('assets/images/user-avatar.png'),
              ), accountEmail: null,
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              title: Text('Food List'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Orders'),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              title: Text('Add new food'),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            // Add more ListTile widgets for additional options
          ],
        ),
      ),
      body: Users(),
    );
  }
}
class Users extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State {
  List<Map<String, dynamic>> _foods = [];

  @override
  void initState() {
    super.initState();
    // Call a function to retrieve the list of foods when the widget initializes
    getFoods();
  }


  Future<void> getFoods() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final foodsReference = databaseReference.child('users');
    await foodsReference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _foods = data.entries.map((entry) {
            Map<String, dynamic> users = entry.value;
            users['key'] = entry.key; // Adding the key (ID) to the food map
            return users;
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 20,
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Number')),
              DataColumn(label: Text('Address')),

            ],
            rows: _foods.map((users) {
              return DataRow(cells: [

                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(users['name'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(users['email'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(users['number'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(users['address'] ??'N/A'),
                  ),
                ),

              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
