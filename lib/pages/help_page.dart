import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class help extends StatelessWidget {
  const help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/helpimage.png', // Replace 'image.png' with your image asset path
                height: 400, // Adjust height as needed
              ),
              SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'How can i help you...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // Adjust as needed
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement submit functionality here
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
