// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:hijri/hijri_calendar.dart';
import 'package:doa_harian/tab_bar.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _today = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('asset/doa.png', width: 100),
            Column(
              children: [
                Text(_today.toFormat("dd MMMM yyyy"),
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "Doa Harian adalah aplikasi doa-doa shohih bersumber dari Quran dan Sunnah",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.white,
                shadowColor: Colors.amber,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: const Size(100, 50), //////// HERE
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeTabs(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Bismillah - Mulai Baca Doa',
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
              ),
            ),
            const Text(
              "v.2.0",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
