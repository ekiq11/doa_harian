// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:doa_harian/tab_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('asset/doa.png', width: 100),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Center(
                child: Text(
                  "Doa Harian adalah aplikasi doa-doa shohih bersumber dari Quran dan Sunnah",
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shadowColor: Colors.black54,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: const Size(100, 50), //////// HERE
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeTabs()));
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Bismillah - Mulai Baca Doa',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            const Text(
              "v.1",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
