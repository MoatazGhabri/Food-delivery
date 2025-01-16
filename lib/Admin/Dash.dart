import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fseg/Admin/List.dart';
import 'package:fseg/form.dart';

import '../firebase_options.dart';
import 'Users.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFoodForm(),
                    ),
                  );
              },
            ),
            // Add more ListTile widgets for additional options
          ],
        ),
      ),
      body: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _numberOfFoods = 0;
  int _numberOfOrders = 0;
  int _numberOfUsers = 0;
  double _revenue = 0.0;

  @override
  void initState() {
    super.initState();
    // Retrieve data from Firebase
    retrieveData();
  }

  void retrieveData() {
    // Retrieve number of foods
    DatabaseReference foodsRef = FirebaseDatabase.instance.reference().child('foods');
    foodsRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        _numberOfFoods = (snapshot.snapshot.value as Map).length;
      });
    });

    // Retrieve number of orders
    DatabaseReference ordersRef = FirebaseDatabase.instance.reference().child('orders');
    ordersRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        _numberOfOrders = (snapshot.snapshot.value as Map).length;
      });
    });

    // Retrieve number of users
    DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');
    usersRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        _numberOfUsers = (snapshot.snapshot.value as Map).length;
      });
    });

    // Calculate revenue from sales
    DatabaseReference salesRef = FirebaseDatabase.instance.reference().child('orders');
    salesRef.once().then((DatabaseEvent snapshot) {
      double totalRevenue = 0.0;
      Map<dynamic, dynamic>? salesData = snapshot.snapshot.value as Map?;
      if (salesData != null) {
        salesData.forEach((key, value) {
          totalRevenue += value['totalPrice']; // Assuming each sale has a 'total' field
        });
      }
      setState(() {
        _revenue = totalRevenue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardCard(
              title: 'Number of Foods',
              value: _numberOfFoods.toString(),
            ),
            DashboardCard(
              title: 'Number of Orders',
              value: _numberOfOrders.toString(),
            ),
            DashboardCard(
              title: 'Number of Users',
              value: _numberOfUsers.toString(),
            ),
            DashboardCard(
              title: 'Revenue from Sales',
              value: '${_revenue.toStringAsFixed(2)} DT',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  DashboardCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              value,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
