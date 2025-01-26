import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOSOLO',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.teal,
          secondary: Colors.green,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _selectedImagePath;
  final List<Map<String, String>> _places = [
    {'name': 'Kerala', 'image': 'assets/kerala.jpeg'},
    {'name': 'Karnataka', 'image': 'assets/karnataka.jpeg'},
    {'name': 'Himachal Pradesh', 'image': 'assets/himachal.jpeg'},
    {'name': 'Delhi', 'image': 'assets/delhi.jpeg'},
    {'name': 'Rajasthan', 'image': 'assets/rajasthan.jpeg'},
    {'name': 'Kashmir', 'image': 'assets/kashmir.jpeg'},
    {'name': 'Ladakh', 'image': 'assets/ladakh.jpeg'},
    {'name': 'Meghalaya', 'image': 'assets/meghalaya.jpeg'},
  ];

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  bool _isAdding = false;

  void _addPlace() {
    if (_placeController.text.isEmpty || _selectedImagePath == null) {
      Fluttertoast.showToast(
        msg: 'Please enter a place name and select an image.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    setState(() {
      _places.add({
        'name': _placeController.text,
        'image': _selectedImagePath!.path, // Use the selected image path
      });
      _placeController.clear();
      _selectedImagePath = null; // Clear the selected image
      _isAdding = false; // Hide the input section after adding
    });
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImagePath =
              File(pickedFile.path); // Update the selected image path
          _imageController.text =
              pickedFile.path; // Update the image controller
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error picking image: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _toggleAddPlace() {
    setState(() {
      _isAdding = !_isAdding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GOSOLO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          if (_isAdding)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _placeController,
                    decoration: InputDecoration(labelText: 'Place Name'),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 100, // Set a fixed height or use SizedBox
                    child: InkWell(
                      onTap: _pickImageFromGallery,
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addPlace,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300],
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Add Place'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (context, index) {
                return buildPlaceTile(
                  context,
                  _places[index]['name']!,
                  _places[index]['image']!,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAddPlace,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildPlaceTile(
      BuildContext context, String placeName, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.teal[200]!, width: 2),
      ),
      child: ListTile(
        onTap: () {
          print('Join $placeName');
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imagePath.startsWith('assets/')
              ? Image.asset(
                  imagePath,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                )
              : imagePath.startsWith('/') // Check if it's a valid file path
                  ? Image.file(
                      File(imagePath),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.image), // Fallback for invalid paths
        ),
        title: Text(
          placeName,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.teal[800],
            fontFamily: 'Bohemian',
          ),
        ),
      ),
    );
  }
}
