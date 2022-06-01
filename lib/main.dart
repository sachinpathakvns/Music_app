import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Future<List<Music>> getApidata() async {
    String url =
        "https://gist.githubusercontent.com/sachinpathakvns/82ee29a904643556d2bfecd63ee0e992/raw/adcb3b996921247370d39f51e802cc4da8cdcd22/mm";

    var result = await http.get(Uri.parse(url));

    var jsondata = json.decode(result.body);
    print(jsondata);
    List<Music> users = [];
    for (var u in jsondata) {
      Music user = Music(u["index"],u["track_name"], u["artist_name"], u["album_name"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  Future<List<Music>> getTrackList() async {
    String url =
        "https://gist.githubusercontent.com/sachinpathakvns/82ee29a904643556d2bfecd63ee0e992/raw/adcb3b996921247370d39f51e802cc4da8cdcd22/mm";

    var result = await http.get(Uri.parse(url));

    var jsondata = json.decode(result.body);
    print(jsondata);
    List<Music> users = [];
    for (var u in jsondata) {
      Music user = Music(u["index"],u["track_name"], u["artist_name"], u["album_name"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  void initState() {
    super.initState();
    getApidata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Center(child: Text('Trending',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25), textAlign: TextAlign.center)),
      ),
      body: Container(
        child: FutureBuilder(
          future: getApidata(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('NO INTERNET CONNECTION'),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.library_music),
                        title: Text(snapshot.data[index].album_name,style: TextStyle(fontSize: 25),),
                        subtitle: Text(snapshot.data[index].track_name,style: TextStyle(fontSize: 18)),
                        trailing: Text(snapshot.data[index].artist_name,style: TextStyle(fontSize: 15)),
                        onTap: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => Detailpage(snapshot.data[index])));},
                      ),
                    ),
                  );
             });
          },
        ),
      ),
    );
  }
}

class Detailpage extends StatelessWidget {
  const Detailpage(data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.black,size: 30),
        backgroundColor: Colors.white,
        title: Text('Track Details',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

class Music {
  final int index;
  final String track_name;
  final String album_name;
  final String artist_name;

  Music(this.index,this.album_name, this.artist_name, this.track_name);
}

class Track{
  final int index;
  final String track_name;
  final String album_name;
  final String artist_name;
  final String Explicit;
  final String Rating;
  final String Lyrics;

  Track(this.Explicit,this.Lyrics,this.Rating,this.index,this.album_name, this.artist_name, this.track_name);
}

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.name, this.about, this.email, this.picture);
}
