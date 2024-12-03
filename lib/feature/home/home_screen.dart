import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int selectedPage;
  final bool showAlreadyLogin;

  const HomeScreen({
    super.key,
    this.selectedPage = 0,
    this.showAlreadyLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true, // Centers the title
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the button
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Floating Action Button Pressed!'),
            ),
          );
        },
        backgroundColor: Colors.blue, // Floating button color
        child: Icon(Icons.add), // Floating button icon
      ),
    );
  }
}
