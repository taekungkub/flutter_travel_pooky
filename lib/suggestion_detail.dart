import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feedback.dart';
import 'models/model_feedback.dart';

class SuggestDetailPage extends StatefulWidget {
  @override
  _SuggestDetailPageState createState() => _SuggestDetailPageState();
}

class _SuggestDetailPageState extends State<SuggestDetailPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final watRef = FirebaseDatabase.instance.reference().child('suggestion');
  List<Test> items;
  StreamSubscription<Event> _onWatAddedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    _onWatAddedSubscription = watRef.onChildAdded.listen(_onWatAdded);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onWatAddedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Feedback',
        ),
      ),
      body: data(),
    );
  }

  Widget data() {
    return Material(
      child: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => _navigateToWat(context, items[index]),
                title: Text(
                  'เรื่อง : ${items[index].title}',
                  style: TextStyle(
                      fontFamily: "Prompt_regular",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () => dialogDelete(index),
                    )
                  ],
                ),
                subtitle: Text(
                  'ผู้ส่ง : ${items[index].name}',
                  style: TextStyle(
                      fontFamily: "Prompt_regular",
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              );
            }),
      ),
    );
  }

  void _onWatAdded(Event event) {
    setState(() {
      items.add(new Test.fromSnapshot(event.snapshot));
    });
  }

  void dialogDelete(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Text("Delete ? "),
              content: new Text("Do yo Delete ? "),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Yes"),
                  onPressed: () {
                    _deletWat(context, items[index], index);
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }

  void _deletWat(BuildContext context, Test travel, int position) async {
    await watRef.child(travel.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToWat(BuildContext context, Test feedback) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage(feedback)),
    );
  }
}
