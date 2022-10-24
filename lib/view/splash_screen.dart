import 'dart:async';

import 'package:alquran_project/baseurl/base_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alquran_project/baseurl/base_app.dart';
import 'package:alquran_project/view/home_page.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Al-Qur'an App",
                style: TextStyle(fontSize: Size.size24, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Center(
                child: Image.asset(BaseAsset.splashPicture, fit: BoxFit.fill)),
          ),
          Expanded(
            child: Center(
              child: SpinKitFadingCube(
                size: Size.size32,
                color: Colors.teal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
