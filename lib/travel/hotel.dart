import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_travel/models/model_travel.dart';

import 'details.dart';

class HotelPage extends StatefulWidget {
  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final watRef = FirebaseDatabase.instance.reference().child('sport');
  List<Travel> items;
  StreamSubscription<Event> _onWatAddedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onWatAddedSubscription = watRef.onChildAdded.listen(_onWatAdded);
  }

  @override
  void dispose() {
    _onWatAddedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: testList(),
        )
      ],
    );
  }

  Widget testList() {
    final tStyle = TextStyle(fontSize: 18);
    return Container(
      child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(items[index].title);
                _goDetailsPage(context, items[index]);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          items[index].imageUrl,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        bottom: 20.0,
                        right: 10.0,
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            color: Colors.white,
                            child: Text(
                                'View :  ${items[index].view.toString()}'))),
                    Positioned(
                      bottom: 20.0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        color: Colors.black.withOpacity(0.7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Hero(
                              tag: items[index],
                              child: Text(items[index].title,
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Prompt_regular")),
                            ),
                            Text(items[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Prompt_regular"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onWatAdded(Event event) {
    setState(() {
      items.add(new Travel.fromSnapshot(event.snapshot));
    });
  }

  void _goDetailsPage(BuildContext context, Travel travel) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detailspage(travel)),
    );

    final viewRef = FirebaseDatabase.instance
        .reference()
        .child('sport')
        .child(travel.id)
        .child('view');

    viewRef.runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0) + 1;

      return transaction;
    });
  }
}
