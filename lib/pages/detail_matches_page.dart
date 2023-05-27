import 'package:flutter/material.dart';
import 'package:responsi_app/model/detail_matches_model.dart';
import 'package:responsi_app/service/base_network.dart';

class DetailMatchesPage extends StatelessWidget {
  String id;
  DetailMatchesPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Match ID: $id')),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: BaseNetwork.get('matches/$id'),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              DetailMatchesModel detailMatches =
                  DetailMatchesModel.fromJson(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.network(
                                'https://flagcdn.com/256x192/${detailMatches.homeTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Text(detailMatches.homeTeam!.name!),
                          ],
                        ),
                        Row(
                          children: [
                            Text(detailMatches.homeTeam!.goals!.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            Text("-"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(detailMatches.awayTeam!.goals!.toString()),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.network(
                                'https://flagcdn.com/256x192/${detailMatches.awayTeam!.country!.substring(0, 2).toLowerCase()}.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Text(detailMatches.awayTeam!.name!),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Stadium : ${detailMatches.venue!}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Location : ${detailMatches.location!}'),
                    SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Statistics',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                _statisticsDetail(
                                    title: 'Ball Possession',
                                    left: detailMatches
                                        .homeTeam!.statistics!.ballPossession!,
                                    right: detailMatches
                                        .awayTeam!.statistics!.ballPossession!),
                                _statisticsDetail(
                                    title: 'Shot',
                                    left: detailMatches
                                        .homeTeam!.statistics!.attemptsOnGoal,
                                    right: detailMatches
                                        .awayTeam!.statistics!.attemptsOnGoal),
                                _statisticsDetail(
                                    title: 'Shot On Goal',
                                    left: detailMatches
                                        .homeTeam!.statistics!.kicksOnTarget,
                                    right: detailMatches
                                        .awayTeam!.statistics!.kicksOnTarget),
                                _statisticsDetail(
                                    title: 'Corners',
                                    left: detailMatches
                                        .homeTeam!.statistics!.corners,
                                    right: detailMatches
                                        .awayTeam!.statistics!.corners),
                                _statisticsDetail(
                                    title: 'Offside',
                                    left: detailMatches
                                        .homeTeam!.statistics!.offsides,
                                    right: detailMatches
                                        .awayTeam!.statistics!.offsides),
                                _statisticsDetail(
                                    title: 'Fouls',
                                    left: detailMatches
                                        .homeTeam!.statistics!.foulsReceived,
                                    right: detailMatches
                                        .awayTeam!.statistics!.foulsReceived),
                                _statisticsDetail(
                                    title: 'Pass Accuracy',
                                    left: _average(
                                        detailMatches.homeTeam!.statistics!
                                            .passesCompleted!,
                                        detailMatches
                                            .homeTeam!.statistics!.passes!),
                                    right: _average(
                                        detailMatches.awayTeam!.statistics!
                                            .passesCompleted!,
                                        detailMatches
                                            .awayTeam!.statistics!.passes!)),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Referees : ',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (int i = 0;
                              i < detailMatches.officials!.length;
                              i++)
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.only(right: 10),
                              child:
                                  Table(border: TableBorder.all(), children: [
                                TableRow(children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child:
                                                Image.asset('assets/fifa.png')),
                                        Text(detailMatches.officials![i].name!,
                                            textAlign: TextAlign.center),
                                        Text(detailMatches.officials![i].role!,
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ])
                              ]),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      )),
    );
  }

  String _average(int complete, int total) {
    int result = ((complete / total) * 100).ceil();
    return (result).toString() + "%";
  }

  Widget _statisticsDetail({title, left, right}) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Text('$title'),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('$left'),
            Text("-"),
            Text('$right'),
          ],
        ),
      ],
    );
  }
}
