import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutternotesapp/urls.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdatePage(
      {Key? key, required this.client, required this.id, required this.note})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  initState() {
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Page")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:TextField(
            controller: controller,
            maxLines: 10,
          )),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
              ),
              onPressed: () {
                widget.client.put(updateUrl(widget.id), body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Update Note"))
        ],
      ),
    );
  }
}
