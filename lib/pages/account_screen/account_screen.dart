import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:30.0),
        child: Column(
          children: <Widget>[
            Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'JosefinSans'
              ),
            ),
            Container(height: 30.0),
            TextField(
              controller: textEditingController,
              decoration:InputDecoration(
                suffixIcon: Icon(Icons.visibility),
                prefixIcon: Icon(Icons.person_outline)
              )
            )

          ],
        ),
      ),
    );
  }
}
