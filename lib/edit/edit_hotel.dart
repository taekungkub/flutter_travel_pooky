import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_travel/add/add_hotel.dart';
import 'package:flutter_travel/models/model_travel.dart';

class EditHotelPage extends StatefulWidget {
  @override
  _EditHotelPageState createState() => _EditHotelPageState();
}

class _EditHotelPageState extends State<EditHotelPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final watRef = FirebaseDatabase.instance.reference().child('sport');
  List<Travel> items;
  StreamSubscription<Event> _onWatAddedSubscription;
  StreamSubscription<Event> _onWatChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    _onWatAddedSubscription = watRef.onChildAdded.listen(_onWatAdded);

    _onWatChangedSubscription = watRef.onChildChanged.listen(_onWatUpdated);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onWatAddedSubscription.cancel();
    _onWatChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'แก้ไขโรงแรม',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
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
                leading: SizedBox(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(color: Colors.black)),
                        child: items[index].imageUrl == null
                            ? null
                            : Image.network(items[index].imageUrl))),
                title: Text(
                  '${items[index].title}',
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
                  '${items[index].name}',
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

  void _onWatAdded(Event event) {
    setState(() {
      items.add(new Travel.fromSnapshot(event.snapshot));
    });
  }

  void _deletWat(BuildContext context, Travel travel, int position) async {
    await watRef.child(travel.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _onWatUpdated(Event event) {
    var oldWatValue =
        items.singleWhere((travel) => travel.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldWatValue)] =
          new Travel.fromSnapshot(event.snapshot);
    });
  }

  void _navigateToWat(BuildContext context, Travel travel) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddHotelPage(travel)),
    );
  }
}
