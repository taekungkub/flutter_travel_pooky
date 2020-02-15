import 'package:flutter/material.dart';
import 'package:flutter_travel/drawer.dart';
import 'package:flutter_travel/travel/hotel.dart';
import 'package:flutter_travel/travel/wat.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'travel/travel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Map> collection = [
    {
      "title": "วัด",
      "subtitle": "",
      "image":
          "https://travel.mthai.com/app/uploads/2016/09/13625398_1311318768880532_6491687747263691633_n-1.jpg",
    },
    {
      "title": "ท่องเที่ยว",
      "subtitle": "",
      "image":
          "https://www.krungsri.com/bank/getmedia/3926a860-3263-46eb-9a21-6130dcd2c6f6/unseen-thailand-clear-water-2.jpg.aspx",
    },
    {
      "title": "ที่พัก",
      "subtitle": "",
      "image":
          "http://img.painaidii.com/images/20190618_3_1560827552_556502.jpg",
    },
  ];

  @override
  final tabController = new DefaultTabController(
      length: 3,
      child: new Scaffold(
        body: new TabBarView(children: [
          new WatPage(),
          new TravelPage(),
          new HotelPage(),
        ]),
        bottomNavigationBar: new TabBar(
          labelStyle: TextStyle(
            fontFamily: "Prompt_regular",
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: "วัด"),
            Tab(
              text: "ท่องเที่ยว",
            ),
            Tab(
              text: "ที่พัก",
            ),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerPage(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
            icon: new Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => _key.currentState.openDrawer()),
      ),
      body: tabController,
    );
  }

  @override
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
    return Container(
      child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: collection.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                var title = collection[index]['title'];
                print(title);
                if (title == "วัด") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WatPage()));
                } else if (title == "ท่องเที่ยว") {
                  // go travel
                } else if (title == "ที่พัก") {
                  // go hotel
                }
              },
              child: Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.only(
                    left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          collection[index]['image'],
                          fit: BoxFit.cover,
                        )),
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
                            Text(collection[index]['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Text(collection[index]['subtitle'],
                                style: TextStyle(color: Colors.white))
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
}
