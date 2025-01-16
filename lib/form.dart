import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fseg/Admin/List.dart';
import 'Admin/Users.dart';
import 'firebase_options.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Users List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Users(),
                  ),
                );
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
      body: AddFoodForm(),
    );
  }
}

class AddFoodForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Food'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FoodForm(),
        ),
      ),
    );
  }
}

class FoodForm extends StatefulWidget {
  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categorieController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();



  List<String> _categories = ['Burger', 'Pizza']; // Add your categories here

  String _selectedCategory = 'Burger'; // Default selected category

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey, // Assign a GlobalKey to the Form widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a descreption';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save the data to Firebase
                  saveFood();
                  Navigator.pop(context); // Close the form after saving
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveFood() {
    // Get the entered data from the text controllers
    String name = _nameController.text;
    String price = _priceController.text;
    String imageUrl = _imageController.text;
    String category = _selectedCategory;
    String descreption = _descController.text;


    // Reference to the 'foods' node in the Firebase Realtime Database
    final DatabaseReference foodsRef =
    FirebaseDatabase.instance.reference().child('foods');

    // Generate a new unique ID for the food item
    String? newFoodKey = foodsRef.push().key;

    // Create a map containing the food data
    Map<String, dynamic> foodData = {
      'name': name,
      'price': price,
      'image': imageUrl,
      'category': category,
      'desc' : descreption,

    };

    // Save the food data to the database under the generated ID
    foodsRef.child(newFoodKey!).set(foodData).then((_) {
      // Data saved successfully
      print('New food item added to the database.');
    }).catchError((error) {
      // An error occurred while saving the data
      print('Failed to add new food item: $error');
    });
  }

  @override
  void dispose() {
    _categorieController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
