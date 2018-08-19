import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top + 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:50.0),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:50.0),
            child: TextField(
              controller: textEditingController,
              decoration:InputDecoration(
                suffixIcon: Icon(Icons.visibility),
                prefixIcon: Icon(Icons.person_outline)
              )
            ),
          ),Container(height:10.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:50.0),
            child: TextField(
                controller: textEditingController,
                decoration:InputDecoration(
                    suffixIcon: Icon(Icons.visibility),
                    prefixIcon: Icon(Icons.mail_outline)
                )
            ),
          ),Container(height:20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:50.0),
            child: TextField(
                controller: textEditingController,
                obscureText: true,
                decoration:InputDecoration(
                    suffixIcon: Icon(Icons.visibility),
                    prefixIcon: Icon(Icons.lock_outline)
                )
            ),
          ),Container(height:30.0),
         Padding(
           padding: EdgeInsets.symmetric(horizontal:50.0),
           child: Center(
             child: Container(
               width: double.infinity,
               padding: EdgeInsets.all(15.0),
               decoration: BoxDecoration(
                 color: Colors.redAccent,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.redAccent,
                     spreadRadius: 5.0,
                     blurRadius: 10.0,
                     offset: Offset(0.0,10.0)
                   ),
                 ],
                 borderRadius: BorderRadius.circular(30.0)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text(
                     'Sign up',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 18.0,
                       fontFamily: 'OpenSans'
                     ),
                   ),
                   Expanded(child: Container(),),
                   Icon(Icons.chevron_right,color: Colors.white,)
                 ],
               ),
             ),
           ),
         ),Container(height:55.0),
          Center(
            child: Text(
                'Have an account ?',
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ),Container(height: 10.0,),
          Center(
            child: Text(
              'SIGN IN',
              style: TextStyle(
                  fontSize: 17.0,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}
