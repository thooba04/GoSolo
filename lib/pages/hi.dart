import 'package:flutter/material.dart';

class HiPage extends StatelessWidget {
  final String email;

  HiPage(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HI $email'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'HI $email',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
