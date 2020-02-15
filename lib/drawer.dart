import 'package:flutter/material.dart';
import 'package:flutter_travel/about.dart';
import 'package:flutter_travel/contact.dart';
import 'package:flutter_travel/login.dart';
import 'package:flutter_travel/suggest.dart';
import 'package:flutter_travel/widgets/oval-right-clipper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Container(
        width: 250,
        child: Drawer(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 20, right: 60),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.blue])),
                  child: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: Image.asset(
                        "images/logo_menu.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "ปทุมธานี",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Prompt_regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "@ตำบลบ้านใหม่ อำเภอเมือง",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Prompt_regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.of(context).pop(context);
                  },
                ),
                buildDivider(),
                ListTile(
                  leading: Icon(FontAwesomeIcons.user),
                  title: Text("Login"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                buildDivider(),
                ListTile(
                  leading: Icon(FontAwesomeIcons.paperPlane),
                  title: Text("About"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
                buildDivider(),
                ListTile(
                  leading: Icon(FontAwesomeIcons.fileContract),
                  title: Text("Contact"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactPage()));
                  },
                ),
                buildDivider(),
                ListTile(
                  leading: Icon(Icons.details),
                  title: Text("Feedback"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuggestPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDivider() {
    return Divider(
      color: Colors.grey.shade400,
    );
  }
}
