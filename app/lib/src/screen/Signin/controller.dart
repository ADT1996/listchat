import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:listchat/src/Common/Common.dart';
import 'package:toast/toast.dart';

import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/non-user.Service.dart';
import 'package:listchat/src/Model/Models.dart';

import './main.dart';

class Controller {
  bool isLoading = false;

  SigninState _screen;

  String email = '';
  String password = '';

  NonUserService _service;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]);
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Controller(SigninState screen) {
    _screen = screen;
    _service = NonUserService();
  }

  void onChangedEmail(String email) => this.email = email;
  void onchangedPassword(String password) => this.password = password;

  void pressGoogleSignIn() {
    _googleSignIn.signIn().then((GoogleSignInAccount result) {
      _screen.setState(() {
        isLoading = true;
      });
      result.authentication.then((GoogleSignInAuthentication auth) async {
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: auth.accessToken, idToken: auth.idToken);
        final FirebaseUser currentUser = await _auth.currentUser();
        String certkey = await _service.getCertKey();
        print('Certkey => $certkey');
        String certKeyEnscrypted = Common.encryptString(certkey);
        print('Certkey enscrypted => $certKeyEnscrypted');

        // Navigator.of(_screen.context).pushReplacementNamed(HOMESCREEN, arguments: currentUser);
        User user =
            await _service.loginByFirebase(currentUser, certKeyEnscrypted);
        if (user != null) {
          Navigator.of(_screen.context)
              .pushReplacementNamed(HOMESCREEN, arguments: user);
        } else {
          Toast.show('Login fail', _screen.context, duration: 5);
        }
        _screen.setState(() {
          isLoading = false;
        });
        return currentUser;
      });
    }, onError: (error) {
      _screen.setState(() {
        isLoading = false;
      });
      print(error);
      Toast.show('Login fail', _screen.context, duration: 5);
    }).catchError((error) {
      _screen.setState(() {
        isLoading = false;
      });
      Toast.show('Exception', _screen.context, duration: 5);
      throw error;
    });
  }

  void Function() login() => () {
        _screen.setState(() {
          isLoading = true;
        });
        _service.login(email, password).then((user) {
          _screen.setState(() {
            isLoading = false;
          });
          if (user == null) {
            Toast.show('Email or password is wrong.', _screen.context,
                duration: 2, gravity: Toast.BOTTOM);
            return;
          }
          Navigator.of(_screen.context)
              .pushReplacementNamed(HOMESCREEN, arguments: user);
        });
      };

  void Function() signUp() => () {
        Navigator.of(_screen.context).pushNamed(REGISTRYSCREEN);
      };
}
