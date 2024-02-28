import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomDogImagesWidget extends StatefulWidget {
  const RandomDogImagesWidget({Key? key}) : super(key: key);

  @override
  State<RandomDogImagesWidget> createState() => _RandomDogImagesWidgetState();
}

class _RandomDogImagesWidgetState extends State<RandomDogImagesWidget> {
  String imageUrl = '';
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    setState(() {
      loaded = false;
    });
    final response = await http.get(Uri.parse(
        'https://dog.ceo/api/breeds/image/random')); // Replace 'https://api.example.com/image' with your actual API endpoint
    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> map = Map.castFrom(json.decode(response.body));
        if (map.isNotEmpty &&
            map.containsKey('message') &&
            map['message'] != null &&
            map['message'].toString().isNotEmpty) {
          imageUrl = json.decode(response.body)['message'];
        }
        loaded = true;
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (imageUrl.isNotEmpty && loaded)
                ? Expanded(child: Image.network(imageUrl))
                : const SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()),
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: loadImage,
                child: const Text('Refresh'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
