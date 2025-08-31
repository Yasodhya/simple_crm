import 'package:flutter/material.dart';
import 'customers/customers_list_screen.dart';
import 'notes/notes_list_screen.dart';
import '../db/database_helper.dart'; // Import DatabaseHelper
import '../screens/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CustomersListScreen(),
    const NotesListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Debug function to print all data in SQLite
  Future<void> _printAllData() async {
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;

    final customers = await db.query('customers');
    print("===== All Customers =====");
    for (var customer in customers) {
      print(customer);
    }

    final notes = await db.query('notes');
    print("===== All Notes =====");
    for (var note in notes) {
      print(note);
    }
    print("=========================");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple CRM"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Logout: navigate to LoginScreen and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Print DB',
            onPressed: _printAllData, // Call debug print function
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Customers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: "Notes",
          ),
        ],
      ),
    );
  }
}
