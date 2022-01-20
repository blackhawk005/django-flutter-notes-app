import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutternotesapp/urls.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({Key? key, required this.client}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Page")),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 50,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(createURL, body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Create Note"))
        ],
      ),
    );
  }
}
