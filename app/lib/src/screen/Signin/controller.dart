import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:toast/toast.dart';

import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/non-user.Service.dart';
import 'package:listchat/src/Model/Models.dart';

import './main.dart';

class Controller {
  SigninState _screen;

  String email = '';
  String password = '';

  NonUserService _service;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Controller(SigninState screen) {
    _screen = screen;
    _service = NonUserService();
  }

  void onChangedEmail(String email) => this.email = email;
  void onchangedPassword(String password) => this.password = password;

  void pressGoogleSignIn() {
    _googleSignIn.signIn().then((GoogleSignInAccount result) async {
      final GoogleSignInAuthentication auth = await result.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken
      );
      final FirebaseUser user =  (await _auth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      // assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Toast.show('Login completed', _screen.context, duration: 5);
      return currentUser;
    },
    onError: (error) {
      print(error);
      Toast.show('Login fail', _screen.context, duration: 5);
    }
    ).catchError((error) {
      Toast.show('Exception', _screen.context, duration: 5);
      throw error;
    });
  }

  void Function() login() => () async {
    print('Login\n');
    User user = await _service.login(email, password);

    if(user == null) {
      print('login fail');
      Toast.show('Email or password is wrong.',_screen.context, duration: 2, gravity: Toast.BOTTOM);
      return;
    }

    print(user.getEmail());
    print(user.getGender());
    print(user.getLastName());
    print(user.getFirstName());
    print(user.getBirthday());
    print(user.getToken());
    Navigator.of(_screen.context).pushReplacementNamed(HOMESCREEN, arguments: user);
  };

  void Function() signUp() => () {
    print('Sign up\n');
    Navigator.of(_screen.context).pushNamed(REGISTRYSCREEN);
  };
}