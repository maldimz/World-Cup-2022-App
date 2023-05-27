import 'package:flutter/material.dart';
import 'package:responsi_app/model/matches_model.dart';
import 'package:responsi_app/pages/detail_matches_page.dart';
import 'package:responsi_app/service/base_network.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pala Dunia 2022'),
        ),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: BaseNetwork.getList('matches'),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                List<MatchesModel> matches = [];
                for (var item in snapshot.data) {
                  matches.add(MatchesModel.fromJson(item));
                }
                return ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    MatchesModel match = matches[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailMatchesPage(id: match.id!),
                            ));
                      },
                      child: Card(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    'https://flagcdn.com/256x192/${match.homeTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                ),
                                Text(match.homeTeam!.name!),
                              ],
                            ),
                            Row(
                              children: [
                                Text(match.homeTeam!.goals!.toString()),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("-"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(match.awayTeam!.goals!.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.network(
                                    'https://flagcdn.com/256x192/${match.awayTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                ),
                                Text(match.awayTeam!.name!),
                              ],
                            ),
                          ],
                        ),
                      )),
                    );
                  },
                );
              }
            },
          ),
        )));
  }
}
