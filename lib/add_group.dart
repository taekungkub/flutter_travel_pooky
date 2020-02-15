import 'package:flutter/material.dart';
import 'package:flutter_travel/add/add_hotel.dart';
import 'package:flutter_travel/add/add_travel.dart';
import 'package:flutter_travel/edit/edit_hotel.dart';
import 'package:flutter_travel/edit/edit_travel.dart';
import 'package:flutter_travel/edit/edit_wat.dart';
import 'package:flutter_travel/models/model_travel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add/add_wat.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Location Lists',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(padding: const EdgeInsets.all(16.0), children: <Widget>[
          Text(
            "เพิ่ม",
            style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                  child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddWatPage(Travel(
                                null,
                                null,
                                null,
                                null,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                null,
                              ))),
                    );
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.plus, "วัด",
                      Colors.deepOrange.withOpacity(0.7)),
                ),
              )),
              const SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTravelPage(Travel(
                              null,
                              null,
                              null,
                              null,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              null))),
                    );
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.plus,
                      "ที่ท่องเที่ยว", Colors.blue.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddHotelPage(Travel(
                              null,
                              null,
                              null,
                              null,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              null))),
                    );
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.plus,
                      "โรงแรม,ที่พัก", Colors.indigo.withOpacity(0.7)),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(child: Text("")),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            "แก้ไข",
            style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                  child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditWatPage()));
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.solidEdit, "วัด",
                      Colors.amber.withOpacity(0.7)),
                ),
              )),
              const SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTravelPage()));
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.solidEdit,
                      "ที่ท่องเที่ยว", Colors.blueGrey.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditHotelPage()));
                  },
                  splashColor: Colors.black,
                  child: _buildWikiCategory(FontAwesomeIcons.solidEdit,
                      "โรงแรม,ที่พัก", Colors.lightBlueAccent.withOpacity(0.7)),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(child: Text("")),
            ],
          ),
          const SizedBox(height: 16.0),
        ]));
  }

  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          child: Opacity(
              opacity: 0.3,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                label,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        )
      ],
    );
  }
}
