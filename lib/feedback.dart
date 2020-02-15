import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/model_feedback.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();

  final Test feedback;
  FeedbackPage(this.feedback);
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  void initState() {
    super.initState();

    print(widget.feedback.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("รายละเอียด"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.blue,
                  ),
                  title: Text(
                    widget.feedback.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Prompt_regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  title: Text(
                    widget.feedback.email,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Prompt_regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  title: Text(
                    widget.feedback.tel,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Prompt_regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                description()
              ],
            ),
          ),
        ));
  }

  Widget description() {
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            FontAwesomeIcons.paperclip,
            color: Colors.blue,
          ),
          title: Text(
            "รายละเอียด",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Prompt_regular",
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Text(
            widget.feedback.issue,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Prompt_regular",
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    ));
  }
}
