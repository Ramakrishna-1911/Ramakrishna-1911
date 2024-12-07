import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const MarketPlace());
}

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farmers MarketPlace',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.green.shade800,
        ),
        body: ProductList(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green.shade800,
          label: const Text('Post Product'),
          icon: const Icon(Icons.add),
          onPressed: () {
            _showPostProductDialog(context);
          },
        ),
      ),
    );
  }

  void _showPostProductDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: PostProductForm(),
          ),
        );
      },
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No products available.'));
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(12.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final data = product.data() as Map<String, dynamic>;
            final imageUrl = data['imageUrl'] as String? ?? '';
            final description = data['description'] as String? ?? 'No description';
            final contact = data['contact'] as String? ?? 'No contact info';
            final productId = product.id;

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: imageUrl.isNotEmpty
                          ? Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity)
                          : const Icon(Icons.image, size: 100, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Contact: $contact',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                imageUrl: imageUrl,
                                description: description,
                                contact: contact,
                              ),
                            ),
                          );
                        },
                        child: const Text('Details'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection('products').doc(productId).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product deleted successfully!')),
                          );
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class PostProductForm extends StatefulWidget {
  @override
  _PostProductFormState createState() => _PostProductFormState();
}

class _PostProductFormState extends State<PostProductForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitProduct() async {
    final description = _descriptionController.text;
    final contact = _contactController.text;

    if (description.isEmpty || contact.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    try {
      final fileName = _selectedImage!.path.split('/').last;
      final storageRef = FirebaseStorage.instance.ref().child('products/$fileName');
      final uploadTask = storageRef.putFile(_selectedImage!);
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('products').add({
        'description': description,
        'contact': contact,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product posted successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Post a Product',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Product Description'),
          ),
          TextField(
            controller: _contactController,
            decoration: const InputDecoration(labelText: 'Contact Information'),
          ),
          const SizedBox(height: 10),
          _selectedImage == null
              ? ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text('Upload Image'),
                )
              : Image.file(_selectedImage!, height: 100),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitProduct,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final String? imageUrl;
  final String description;
  final String contact;

  const ProductDetail({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Display description when image is tapped
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Product Description'),
                          content: Text(description),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl!,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.shopping_bag,
                          size: 150,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Display contact info when contact is tapped
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Contact Information'),
                        content: Text(contact),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    Text(
                      'Contact Information:',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(contact, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
