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
      body: FoodListPage(),
    );
  }
}
class FoodListPage extends StatefulWidget {
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
    final foodsReference = databaseReference.child('foods');
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
  void _showDeleteFoodDialog(Map<String, dynamic> food) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Food'),
          content: Text('Are you sure you want to delete this food item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                final databaseReference = FirebaseDatabase.instance.ref();
                final foodsReference = databaseReference.child('foods');
                foodsReference.child(food['key']).remove();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showModifyFoodDialog(Map<String, dynamic> food) {
    TextEditingController nameController = TextEditingController(text: food['name']);
    TextEditingController priceController = TextEditingController(text: food['price'].toString());
    TextEditingController categoryController = TextEditingController(text: food['category']);
    TextEditingController imageController = TextEditingController(text: food['image']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modify Food'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save modification logic here
                setState(() {
                  food['name'] = nameController.text;
                  food['price'] = int.parse(priceController.text);
                  food['category'] = categoryController.text;
                  food['image'] = imageController.text;

                });
                final databaseReference = FirebaseDatabase.instance.ref();
                final foodsReference = databaseReference.child('foods');
                foodsReference.child(food['key']).update({
                  'name': food['name'],
                  'price': food['price'],
                  'category': food['category'],
                  'image': food['image'],
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
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
                      _showModifyFoodDialog(food);
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteFoodDialog(food);
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
