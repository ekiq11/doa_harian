import 'package:doa_harian/view/doa_dzikir/dzikir_pagi_petang.dart';
import 'package:doa_harian/view/doa_dzikir/dzikir_setelah_sholat.dart';
import 'package:flutter/material.dart';

class Dzikir extends StatefulWidget {
  const Dzikir({Key? key}) : super(key: key);

  @override
  State<Dzikir> createState() => _DzikirState();
}

class _DzikirState extends State<Dzikir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DzikirPagiPetang(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        const Text(
                          "1",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 8.5),
                                child: Text(
                                  "Dzikir Pagi dan Sore",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade500,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DzikirSetelahSholat(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        const Text(
                          "2",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 8.5),
                                child: Text(
                                  "Dzikir Setelah Sholat",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade500,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
