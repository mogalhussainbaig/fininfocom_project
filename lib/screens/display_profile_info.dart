import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test_project/models/display_profile_info_model.dart';

class DisplayProfileInfo extends StatefulWidget {
  const DisplayProfileInfo({Key? key}) : super(key: key);

  @override
  State<DisplayProfileInfo> createState() => _DisplayProfileInfoState();
}

class _DisplayProfileInfoState extends State<DisplayProfileInfo> {
  DisplayProfileInfoModel? displayProfileInfoModel;
  String? name, location, email, dob;

  @override
  void initState() {
    super.initState();
    fetchProfileInfo();
  }

  Future<void> fetchProfileInfo() async {
    final response = await http.get(Uri.parse(
        'https://randomuser.me/api/')); // Replace 'https://api.example.com/image' with your actual API endpoint
    if (response.statusCode == 200) {
      displayProfileInfoModel = displayProfileInfoModelFromJson(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load image');
    }
  }

  String calculateDaysSinceRegistered(DateTime registeredDate) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(registeredDate);
    return difference.inDays.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  const Icon(Icons.arrow_back_outlined, color: Colors.black)),
        ),
        body: displayProfileInfoModel == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Image.network(
                    displayProfileInfoModel!.results[0].picture.large,
                    scale: 1,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text(
                          'unable to load the image size is very small');
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '${displayProfileInfoModel!.results[0].name.title} ${displayProfileInfoModel!.results[0].name.first} ${displayProfileInfoModel!.results[0].name.last}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                      'Location: ${displayProfileInfoModel!.results[0].location.city}, ${displayProfileInfoModel!.results[0].location.country}'),
                  const SizedBox(height: 8.0),
                  Text('Email: ${displayProfileInfoModel!.results[0].email}'),
                  const SizedBox(height: 8.0),
                  Text(
                      'Date of Birth: ${DateFormat('yyyy-MM-dd').format(displayProfileInfoModel!.results[0].dob.date)}'),
                  const SizedBox(height: 8.0),
                  Text(
                      'Number of days since registered: ${calculateDaysSinceRegistered(displayProfileInfoModel!.results[0].registered.date)} days'),
                ],
              ),
      ),
    );
  }
}
