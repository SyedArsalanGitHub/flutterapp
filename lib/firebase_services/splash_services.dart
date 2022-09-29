
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterproject/ui/auth/phone auth/login_screen.dart';
import 'package:flutterproject/ui/screens/home_screen.dart';


class SplashServices{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser; // Getting detial of the current user that either user is login or not

    if(user!=null){
      Timer(const Duration(seconds: 3),
            () =>
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen())),
      );
    }

    else {
      Timer(const Duration(seconds: 3),
              () =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()))
      );
    }


  }
}