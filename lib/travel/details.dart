import 'package:flutter/material.dart';
import 'package:flutter_travel/models/model_travel.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailspage extends StatefulWidget {
  final Travel travel;
  Detailspage(this.travel);
  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  String title = '';
  String name = '';
  String call = '';
  String track = '';
  String address = '';
  String time = '';
  String des = '';
  String imageUrl = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';
  List list = [];

  @override
  void initState() {
    super.initState();

    title = widget.travel.title;
    name = widget.travel.name;
    des = widget.travel.desc;
    time = widget.travel.time;
    call = widget.travel.call;
    track = widget.travel.track;
    address = widget.travel.address;
    imageUrl = widget.travel.imageUrl;
    imageUrl2 = widget.travel.imageUrl2;
    imageUrl3 = widget.travel.imageUrl3;
    imageUrl4 = widget.travel.imageUrl4;
    list.add(imageUrl);
    list.add(imageUrl2);
    list.add(imageUrl3);
    list.add(imageUrl4);
    print(call);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: btnTrack(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
              fontFamily: "Prompt_regular", fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _imageCover(),
          _infomation(),
          description(),
        ],
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 300,
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              list[index],
              fit: BoxFit.cover,
            ),
          );
        },
        itemWidth: 300,
        itemCount: list.length,
        layout: SwiperLayout.STACK,
        loop: true,
      ),
    );
  }

  Widget _infomation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                FontAwesomeIcons.cube,
                color: Colors.blue,
              ),
              title: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Prompt_regular",
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Prompt_regular",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.clock,
                color: Colors.blue,
              ),
              title: Text(
                time,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Prompt_regular",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.mobileAlt,
                color: Colors.blue,
              ),
              title: Text(
                call,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Prompt_regular",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.mapMarkedAlt,
                color: Colors.blue,
              ),
              title: Text(
                address,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Prompt_regular",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget description() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 15, bottom: 15),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                FontAwesomeIcons.audioDescription,
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
                des,
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

  Widget btnTrack() {
    return Container(
      padding: EdgeInsets.all(15),
      child: FloatingActionButton(
        child: Icon(
          Icons.navigation,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        onPressed: () => _launchURL(),
      ),
    );
  }

  _launchURL() async {
    try {
      var url = track;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }
}
