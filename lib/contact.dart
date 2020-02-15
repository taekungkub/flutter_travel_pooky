import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: btnTrack(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Contact",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: Image.asset(
                  "images/logo_menu.png",
                  width: 150,
                ),
              ),
            ),
            Text(
              "ติดต่อเทศบาลบ้านใหม่",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Prompt_regular",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                title: Text(
                  "0-2501-1721",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Prompt_regular",
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "ต.บ้านใหม่ อ.เมือง จ.ปทุมธานี 12000",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Prompt_regular",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.grey.shade400,
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                title: Text(
                  "admin@baanmai.go.th",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Prompt_regular",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.grey.shade400,
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.black,
                      child: _buildWikiCategory(FontAwesomeIcons.facebook,
                          "Facebook", Colors.lightBlueAccent.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        goWebsite();
                      },
                      splashColor: Colors.black,
                      child: _buildWikiCategory(
                          Icons.web, "Website", Colors.green.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  _launchURL() async {
    try {
      var url =
          "https://www.google.com/maps/dir//13.9626536,100.5423162/@13.962654,100.542316,2174m/data=!3m1!1e3?hl=en-US";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }

  goFacebook() async {
    try {
      var url =
          "https://www.google.com/maps/dir//13.9626536,100.5423162/@13.962654,100.542316,2174m/data=!3m1!1e3?hl=en-US";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }

  goWebsite() async {
    try {
      var url = "http://baanmai.go.th/public/";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }
}
