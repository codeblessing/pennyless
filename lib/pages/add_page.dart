// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pennyless/data/prices.dart';
import 'package:pennyless/database.dart';
import 'package:pennyless/ext/utils/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final id = const Uuid().v4();
  final name = TextEditingController();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _submit() async {
    var position = await _determinePosition();
    var station = {
      "id": id,
      "name": name.text,
      "latitude": position.latitude,
      "longitude": position.longitude,
    };

    var result = await supabase.from('stations').upsert(station).execute();
    await Database().fetch();

    if (mounted) {
      if (result.error != null) {
        context.showErrorSnackBar(message: "Cannot add station");
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/edit_prices', (_) => false,
            arguments: Prices(id, 0.0, 0.0, 0.0, 0.0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add station')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: 400.0,
            minHeight: 200.0,
            maxHeight: 500.0,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration:
                        const InputDecoration(labelText: "Station name"),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Submit"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
