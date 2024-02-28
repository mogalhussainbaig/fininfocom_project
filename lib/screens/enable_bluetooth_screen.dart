import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class EnableBluetoothScreen extends StatefulWidget {
  const EnableBluetoothScreen({Key? key}) : super(key: key);

  @override
  State<EnableBluetoothScreen> createState() => _EnableBluetoothScreenState();
}

class _EnableBluetoothScreenState extends State<EnableBluetoothScreen> {
  static const MethodChannel _channel = MethodChannel('bluetooth_channel');

  bool _isAndroid = false;
  bool _isIOS = false;
  bool isBluetoothEnable = false;

  @override
  void initState() {
    super.initState();
    _checkPlatform();
  }

  Future<void> _checkPlatform() async {
    try {
      if (Platform.isAndroid) {
        setState(() {
          _isAndroid = true;
        });
      } else if (Platform.isIOS) {
        setState(() {
          _isIOS = true;
        });
      }
    } catch (e) {
      print("Failed to check platform: $e");
    }
  }

  void enableAndroidBlueTooth() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      return;
    }
    if (!await Permission.bluetoothConnect.isGranted) {
      await Permission.bluetoothConnect.request();
    }
    if (Platform.isAndroid) {
      if (!isBluetoothEnable) {
        await FlutterBluePlus.turnOn().then((value) {
          isBluetoothEnable = true;
        });
      } else {
        await FlutterBluePlus.turnOff().then((value) {
          isBluetoothEnable = false;
        });
      }
    }else{
      await FlutterBluePlus.turnOn().then((value) {
        isBluetoothEnable = true;
      });
    }
    setState(() {});
  }

  Future<void> enableBluetooth() async {
    try {
      if (_isAndroid) {
        enableAndroidBlueTooth();
      } else if (_isIOS) {
        // Handle iOS specific logic
        // For example, display a dialog to request Bluetooth permission
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Enable Bluetooth'),
              content:
                  const Text('Please enable Bluetooth in Settings to proceed.'),
              actions: [
                TextButton(
                  onPressed: () {
                    enableAndroidBlueTooth();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on PlatformException catch (e) {
      print("Failed to enable Bluetooth: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: enableBluetooth,
          child: Text(_isAndroid
              ? '${isBluetoothEnable ? 'BlueToothOn' : 'BlueToothOff'} (Android)'
              : 'Enable Bluetooth (iOS)'),
        ),
      ),
    );
  }
}
