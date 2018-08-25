import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/account_screen/account_bloc.dart';

class AccountScreen extends StatelessWidget {

  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<AccountBloc>(
        builder: (BuildContext context , Widget child , AccountBloc model){
          return StreamBuilder(
            stream: model.userData.asBroadcastStream(),
            builder: (BuildContext context , AsyncSnapshot<User> snapshot){
              if(snapshot.hasData && snapshot.data.uid !=null){
                return new UserProfile(
                  accountBloc: model,
                  background: 'assets/image/placeholder.jpg',
                  user: snapshot.data,
                );
              }else{
                return new SignUp(
                    model: model,
                    facebookSignIn: model.facebookSignIn,
                    textEditingController: textEditingController,
                    onGoogleTap:(){
                      model.googleLogin().then((FirebaseUser user){
                        print(user.email);
                        model.addUserToFireStore(user);
                      });
                    }
                );
              }
            },
          );
        },
      ),
    );
  }
}



class SignUp extends StatelessWidget {
   TextEditingController textEditingController;
   TextEditingController emailEditingController;
   TextEditingController passwordEditingController;

   final Function facebookSignIn;
final Function onGoogleTap;
final AccountBloc model;
   SignUp({
    Key key,
     this.facebookSignIn,
    this.model,
    this.onGoogleTap,
    @required this.textEditingController,
  }) : super(key: key){
    textEditingController = new TextEditingController();
    emailEditingController = new TextEditingController();
    passwordEditingController = new TextEditingController();

   }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).padding.top + 30.0,
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
                  controller: emailEditingController,
                  decoration:InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      prefixIcon: Icon(Icons.mail_outline)
                  )
              ),
            ),Container(height:20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:50.0),
              child: TextField(
                  controller: passwordEditingController,
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
                 padding: EdgeInsets.all(10.0),
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
                 child: FlatButton(
                   onPressed: (){
                     model.emailLogin(
                       emailEditingController.text,
                       passwordEditingController.text
                     );
                   },
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
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
            FlatButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return SignIn(
                      onLoginTapped: (String email, String password){
                        model.emailLogin(email,password).then((FirebaseUser user){
                          model.addUserToFireStore(user,'Anonymous');
                        });
                      },
                    );
                  }
                );
              },
              child: Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 17.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),Container(height:30.0),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                FlatButton(
                  onPressed:(){

                  },
                  child:Image.asset('assets/image/google.png',fit: BoxFit.cover,height: 70.0,width:70.0)
                ),
                FlatButton(
                    onPressed: onGoogleTap,
                    child:Image.asset('assets/image/fbicon.png',fit: BoxFit.cover,height: 70.0,width:70.0)
                ),
                FlatButton(
                    onPressed:facebookSignIn,
                    child:Image.asset('assets/image/twitter.png',fit: BoxFit.cover,height: 70.0,width:70.0)
                )
              ]
            )
          ],
        ),
    );
    }
}

class SignIn extends StatelessWidget {
  TextEditingController emailEditingController;
  TextEditingController passwordEditingController;
  final Function onLoginTapped;
  SignIn({
    this.onLoginTapped
    }){
    emailEditingController = new TextEditingController();
    passwordEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Sign in',
        style: TextStyle(
          fontFamily: 'JosefinSans',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              controller: emailEditingController,
              decoration:InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline)
              )
          ),
          TextField(
              controller: passwordEditingController,
              decoration:InputDecoration(
                  suffixIcon: Icon(Icons.visibility),
                  prefixIcon: Icon(Icons.lock_outline)
              )
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            onLoginTapped(emailEditingController.text,passwordEditingController.text);
          },
          child: Text(
            'LOGIN',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}




class UserProfile extends StatelessWidget {
  final String background;
  final User user;
  final AccountBloc accountBloc;
  UserProfile({
    this.user,
    this.background,
    this.accountBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          accountBloc.logoutFireBase(context).then((_){
            print('loggedout');
          });
        },
        child: Icon(Icons.exit_to_app,color: Colors.white,)
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top:0.0,
            left:0.0,
            right: 0.0,
            height: MediaQuery.of(context).size.height * 0.7,
            child: CachedNetworkImage(
                imageUrl: '',
                placeholder: Image.asset(background,fit: BoxFit.cover,),
              ),
          ),
          ClipOval(
            clipper: OvalClipper(revealPercent: 0.4),
            child: Container(color:Colors.white,),
          ),
          Positioned(
            top:MediaQuery.of(context).size.height * 0.4,
            child: Container(
              alignment: Alignment.center,
              height:100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color:Colors.grey,
                image:DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    user.photoUrl,
                  )
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10.0,
                    spreadRadius: 5.0
                  )
                ],
                shape: BoxShape.circle
              ),
            )
          ),
          Positioned(
            top:MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: <Widget>[
                Text(
                  user.displayName,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 26.0,
                    color: Colors.black54
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



class OvalClipper extends CustomClipper<Rect>{
  final double revealPercent;

  OvalClipper({
    this.revealPercent
  });
Path path = new Path();
  @override
  Rect getClip(Size size) {

    final epicenter = new Offset(size.width / 2, size.height * 0.9);

    // Calculate distance from epicenter to the top left corner to make sure we fill the screen.
    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return new Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}