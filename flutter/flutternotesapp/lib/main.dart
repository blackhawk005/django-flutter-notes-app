import 'dart:convert';
import 'package:flutternotesapp/note.dart';
import 'package:flutter/material.dart';
import 'package:flutternotesapp/create.dart';
import 'package:flutternotesapp/update.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutternotesapp/urls.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Django Flutter Notes App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];
  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  _retrieveNotes() async {
    notes = [];

    List response = json.decode((await client.get(retrieveUrl)).body);
    for (var element in response) {
      notes.add(Note.fromMap(element));
    }
    setState(() {});
  }


  void _deleteNote(int id) {
    client.delete(deleteUrl(id));
    _retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            _retrieveNotes();
          },
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.grey[9],
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white30, width: 9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(notes[index].note),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdatePage(
                                client: client,
                                note: notes[index].note,
                                id: notes[index].id,
                              )));
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteNote(notes[index].id),
                    ),
                  ),
                )
              );
            },
          )
        ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(highlightColor: Colors.orange),
        child: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreatePage(
                  client: client,
                ))),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
