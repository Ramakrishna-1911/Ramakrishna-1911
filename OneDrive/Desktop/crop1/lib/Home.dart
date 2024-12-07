import 'package:flutter/material.dart';
import 'package:crop1/Community.dart';
import 'package:crop1/Learning.dart';
import 'package:crop1/Suggestion.dart';
import 'package:crop1/homepage.dart';
import 'package:crop1/market.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  // Screens for Bottom Navigation Bar
  final List<Widget> _pages = [
    Homepage(),
    CropSuggestionApp(),
    MarketPlace(),
    VideoPage(),
    CommunityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "WasteWise",
            style: TextStyle(backgroundColor: Colors.black12),
          ),
          backgroundColor: Colors.green,
        ),
        body: _pages[_currentIndex], // Show the selected page
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red, // Background color of the bar
          selectedItemColor: Colors.black, // Color of selected item
          unselectedItemColor: Colors.black54,
          currentIndex: _currentIndex, // Track the selected index
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the index when a tab is tapped
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Suggestion',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Learning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Community',
            ),
          ],
        ),
      ),
    );
  }
}

