import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_gmap_json/team.dart';
import 'package:flutter_gmap_json/teamlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Premier League Team';
  List data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: new Container(
          child: new Center(
              child: new FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/team.json'),
            builder: (context, snapshot) {
              List<Team> teams = parseJson(snapshot.data.toString());
              if (snapshot.connectionState != ConnectionState.done) {
                if (teams == null) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else {
                  return new TeamList(
                    team: teams,
                  );
                }
              } else {
                return new TeamList(
                  team: teams,
                );
              }
            },
          )),
        ),
      ),
    );
  }

  List<Team> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Team>((json) => new Team.fromJson(json)).toList();
  }
}
