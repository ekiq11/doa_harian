import 'dart:async';
import 'package:doa_harian/model/model_doa.dart';
import 'package:doa_harian/service/search_service.dart';
import 'package:doa_harian/view/doa_dzikir/detail_doa.dart';
import 'package:flutter/material.dart';
import 'widget_search.dart';

class SearchDoa extends StatefulWidget {
  const SearchDoa({Key? key}) : super(key: key);

  @override
  _SearchDoaState createState() => _SearchDoaState();
}

class _SearchDoaState extends State<SearchDoa> {
  List<Doa>? data = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final data = await SearchService.readFile(query);

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final dataDoa = data![index];
                if (data != null) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDoa(
                                  nama: dataDoa.nama,
                                  lafal: dataDoa.lafal,
                                  transliterasi: dataDoa.transliterasi,
                                  arti: dataDoa.arti,
                                  riwayat: dataDoa.riwayat,
                                  keterangan: dataDoa.keterangan),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                dataDoa.idDoa.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.5),
                                      child: Text(
                                        dataDoa.nama.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
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
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Cari Doa',
        onChanged: searchDoa,
      );

  Widget buildDoa(Doa data) => ListTile(
        title: Text(data.nama.toString()),
      );

  Future searchDoa(String query) async => debounce(() async {
        final data = await SearchService.readFile(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.data = data;
        });
      });
}
