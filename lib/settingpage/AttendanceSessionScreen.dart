import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendanceSessionScreen extends StatefulWidget {
  @override
  _AttendanceSessionScreenState createState() => _AttendanceSessionScreenState();
}

class _AttendanceSessionScreenState extends State<AttendanceSessionScreen> {
  String name = '';
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  LatLng? location;

  Future<void> _pickDateTime(bool isStart) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDateTime : endDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ) ?? startDateTime;

    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(picked),
    ) ?? TimeOfDay.fromDateTime(picked);

    setState(() {
      if (isStart) {
        startDateTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
      } else {
        endDateTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
      }
    });
  }

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      location = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Session')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: 16),
            Text('Start Time: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime)}'),
            ElevatedButton(
              onPressed: () => _pickDateTime(true),
              child: Text('Pick Start Time'),
            ),
            SizedBox(height: 16),
            Text('End Time: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime)}'),
            ElevatedButton(
              onPressed: () => _pickDateTime(false),
              child: Text('Pick End Time'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Get Current Location'),
            ),
            if (location != null)
              Text('Location: ${location!.latitude}, ${location!.longitude}'),
            SizedBox(height: 20),
            if (location != null)
              Container(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: location!,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: location!,
                    ),
                  },
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle attendance submission
                // You can save the name, startDateTime, endDateTime, and location here
              },
              child: Text('Submit Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
