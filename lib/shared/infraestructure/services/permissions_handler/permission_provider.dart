import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider = FutureProvider<void>((ref) async {
  final locationStatus = await Permission.location.request();
  if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
    throw Exception("Location permission is required.");
  }

  // final bluetooth = FlutterBluePlus.instance;
  // final isBluetoothOn = await bluetooth.isOn;
  // if (!isBluetoothOn) {
  //   throw Exception("Bluetooth must be turned on.");
  // }
});
