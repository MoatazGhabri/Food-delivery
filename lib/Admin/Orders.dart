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
      body: Orders(),
    );
  }
}
class Orders extends StatefulWidget {
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
    final foodsReference = databaseReference.child('orders');
    await foodsReference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _foods = data.entries.map((entry) {
            Map<String, dynamic> food = entry.value;
            food['key'] = entry.key; // Adding the key (ID) to the food map
            return food;
          }).toList();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 20,
            columns: [
              DataColumn(label: Text('Food Name')),
              DataColumn(label: Text('Food Name')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Image')),
              DataColumn(label: Text('Modify')),
              DataColumn(label: Text('Delete')),
            ],
            rows: _foods.map((food) {
              return DataRow(cells: [
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(food['key'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(food['name'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(food['price']?.toString() ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(food['category'] ?? 'N/A'),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: food['image'] != null ? Image.network(food['image']) : SizedBox(),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete logic here
                      // For example, you can show a confirmation dialog and then delete the food item
                    },
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
