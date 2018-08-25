
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AccountBloc extends Model {

  final Firestore firestore;
  FirebaseUser firebaseUser;

  BehaviorSubject<User> userData = new BehaviorSubject<User>();

  AccountBloc(this.firestore){
    userData.listen((User user){
      print(user.displayName);
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  bool get isLogin => firebaseUser != null && firebaseUser.getIdToken() != null;

  Future<FirebaseUser> emailLogin(String email, String password) async {
    firebaseUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return firebaseUser;
  }

  Future<FirebaseUser> emailSignUp(String email, String password, String displayName) async {
    firebaseUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return firebaseUser;
  }

  Future<FirebaseUser> facebookSignIn() async{
    var facebookLogin = new FacebookLogin();
    var result =  await facebookLogin.logInWithReadPermissions(['email','public_profile']);
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        firebaseUser = await FirebaseAuth.instance.signInWithFacebook(accessToken: result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled by user");
        break;
      case FacebookLoginStatus.error:
        print('facebook Signin failed');
        print(FacebookLoginStatus.error.toString());
        throw new StateError(FacebookLoginStatus.error.toString());
    }
    return firebaseUser;
  }

  Future<FirebaseUser> googleLogin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    firebaseUser = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + firebaseUser.displayName);
    return firebaseUser;
  }

  Future<bool> addUserToFireStore(FirebaseUser firebasUser, [String userName]) async {
    User user = new User(
      displayName: firebasUser.displayName != null ? firebasUser.displayName : userName,
      email: firebasUser.email,
      photoUrl: firebaseUser.photoUrl != null ? firebasUser.photoUrl : 'https://flutter.io/images/flutter-mark-square-100.png',
      uid: firebasUser.uid
    );

     bool response = await firestore.collection('users').document(user.uid).setData(
          {
            "displayName":user.displayName,
            "email":user.email,
            "photoUrl":user.photoUrl,
            "uid":user.uid
          }
      ).then((_)async {
        final userDoc = await firestore.collection('users').document(user.uid).get();
        userData.add(new User(
            displayName: userDoc['displayName'].toString(),
            email: userDoc['email'].toString(),
            photoUrl: userDoc['photoUrl'].toString(),
            uid: userDoc['uid'].toString()
        ));
        return true;
      }).catchError((err){
        print(err);
        return false;
      });
     return response;

  }

  Future<bool> logoutFireBase(BuildContext context) async{
    bool result;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text('Are you sure ?'),
        actions: <Widget>[
            FlatButton(
              onPressed: () async {
                result = await _auth.signOut().then((_){
                  userData.add(new User());
                  Navigator.pop(context);
                  return true;
                });
              },
              child: Text('Yes'),
            ),
            FlatButton(
              onPressed: (){
                result = false;
                Navigator.pop(context);
              },
              child: Text('No'),
            )
          ],
        );
      }
    );
    return result;
  }
}



  class User{
  String displayName;
  String photoUrl;
  String email;
  String uid;
    User({
      this.displayName,
      this.uid,
      this.photoUrl,
      this.email
    });


  }