import 'package:crop1/Login.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample list of image URLs
  final List<String> images = [
    'https://www.gannett-cdn.com/media/USATODAY/USATODAY/2013/03/28/corn-16_9.jpg?width=3200&height=1680&fit=crop',
    'https://grist.org/wp-content/uploads/2023/03/farm-crops-california-sun.jpg',
    'https://images.tractorgyan.com/uploads/26140/6253d74a28e00_rabi-crop.jpg',
    'https://thumbs.dreamstime.com/z/female-farmer-picking-crops-organic-lettuce-vegetable-plantation-skilled-asian-working-leafy-sunny-spring-day-green-253929253.jpg',
  ];

  @override
  void initState() {
    super.initState();

    // Set up auto-scrolling
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for dynamic sizing
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Homepage'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Image Carousel
                Container(
                  height: screenHeight * 0.6, // 60% of screen height
                  width: screenWidth * 0.9, // 90% of screen width
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                // Waste Calculator Container
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WasteCalculatorApp(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.2, // 20% of screen height
                    width: screenWidth * 0.9,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Find your price',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(const WasteCalculatorApp());
}

class WasteCalculatorApp extends StatelessWidget {
  const WasteCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Waste Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CropWasteCalculatorPage(),
    );
  }
}

class CropWasteCalculatorPage extends StatefulWidget {
  const CropWasteCalculatorPage({super.key});

  @override
  State<CropWasteCalculatorPage> createState() =>
      _CropWasteCalculatorPageState();
}

class _CropWasteCalculatorPageState extends State<CropWasteCalculatorPage> {
  final TextEditingController _cropController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _result = '';
  String _wastageDetails = '';

  final List<Map<String, dynamic>> cropDatabase = [
    {'Crop Name': 'Wheat', 'Wastage': 'Straw, Husk', 'Approx Value (INR per kg)': 1.5},
    {'Crop Name': 'Rice', 'Wastage': 'Husk, Bran', 'Approx Value (INR per kg)': 2.0},
    {'Crop Name': 'Sugarcane', 'Wastage': 'Bagasse, Molasses', 'Approx Value (INR per kg)': 0.5},
    {'Crop Name': 'Corn', 'Wastage': 'Stalks, Cobs', 'Approx Value (INR per kg)': 1.0},
    {'Crop Name': 'Banana', 'Wastage': 'Peels, Stems', 'Approx Value (INR per kg)': 0.8},
    // Add other crops from the dataset here.
  ];

  void _calculateWasteValue() {
    final String cropName = _cropController.text.trim();
    final double? quantity = double.tryParse(_quantityController.text);

    if (cropName.isEmpty || quantity == null || quantity <= 0) {
      setState(() {
        _result = 'Please enter a valid crop name and quantity.';
        _wastageDetails = '';
      });
      return;
    }

    final cropData = cropDatabase.firstWhere(
      (crop) => crop['Crop Name'].toLowerCase() == cropName.toLowerCase(),
      orElse: () => {},
    );

    if (cropData.isEmpty) {
      setState(() {
        _result = 'Crop not found. Please try again.';
        _wastageDetails = '';
      });
      return;
    }

    final double pricePerKg = cropData['Approx Value (INR per kg)'];
    final double totalPrice = pricePerKg * quantity;

    setState(() {
      _result = 'Total Value: ₹${totalPrice.toStringAsFixed(2)}';
      _wastageDetails =
          'Wastage: ${cropData['Wastage']}\nApprox Value: ₹${pricePerKg.toStringAsFixed(2)} per kg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Waste Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calculate Market Value of Crop Waste',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cropController,
              decoration: const InputDecoration(
                labelText: 'Enter Crop Name',
                prefixIcon: Icon(Icons.search, color: Colors.green),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Quantity (kg)',
                prefixIcon: Icon(Icons.scale, color: Colors.green),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateWasteValue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_wastageDetails.isNotEmpty)
              Card(
                color: Colors.lightGreen.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _wastageDetails,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            if (_result.isNotEmpty)
              Card(
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _result,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
