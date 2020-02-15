import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_travel/add_group.dart';
import 'package:flutter_travel/register.dart';
import 'package:flutter_travel/suggestion_detail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:compressimage/compressimage.dart';

import 'home.dart';

class UserPage extends StatefulWidget {
  final FirebaseUser user;
  UserPage(this.user, {Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserUpdateInfo userUpdateInfo = UserUpdateInfo();
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://fireship-lessons.appspot.com');

  File _image;

  String _name = '';
  String _email = '';
  String _photourl = '';

  final nameController = new TextEditingController();

  final userRef = FirebaseDatabase.instance.reference().child('users');

  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    _name = widget.user.displayName;
    _email = widget.user.email;
    _photourl = widget.user.photoUrl;
    nameController.text = _name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(_email),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOut(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                  "images/slideone_1_1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              _showCircularProgress(),
              imageCover(),
              _buildBody(),
            ],
          ),
        ));
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
        ),
        listDetail(),
      ],
    );
  }

  Widget imageCover() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.blue,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 120.0,
                          height: 120.0,
                          child: (_photourl == null)
                              ? Image.network(
                                  'https://img.pngio.com/user-icons-free-download-png-and-svg-user-png-200_200.png')
                              : Image.network(
                                  _photourl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 120),
                  child: buttonImage(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonImage() {
    return Container(
      width: 30,
      child: FloatingActionButton(
        child: Icon(
          Icons.add_a_photo,
          size: 15,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () => getImage(),
      ),
    );
  }

  Widget listDetail() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Name",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: Text(
              _name == null ? "-" : _name,
              style: TextStyle(fontSize: 18.0),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
            ),
            onTap: () => reNameForm(),
          ),
          // ListTile(
          //   title: Text(
          //     "Email",
          //     style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
          //   ),
          //   subtitle: Text(
          //     _email,
          //     style: TextStyle(fontSize: 18.0),
          //   ),
          //   trailing: IconButton(
          //     icon: Icon(Icons.edit),
          //     onPressed: () => reEmailForm(),
          //   ),
          // ),

          Divider(),

          ListTile(
            title: Text(
              "Manage Localtion",
              style: TextStyle(color: Colors.deepOrange, fontSize: 15.0),
            ),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
            ),
            onTap: () {
              print("Manage Location");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddGroupPage()));
            },
          ),

          Divider(),

          ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(color: Colors.deepOrange, fontSize: 15.0),
            ),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuggestDetailPage()));
            },
          ),

          // Container(
          //     child: _email == "pooky@admin.com"
          //         ? ListTile(
          //             title: Text(
          //               "จัดการผู้ดูแลระบบ",
          //               style:
          //                   TextStyle(color: Colors.deepOrange, fontSize: 15.0),
          //             ),
          //             trailing: IconButton(
          //               icon: Icon(Icons.chevron_right),
          //             ),
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => RegisterPage()));
          //             },
          //           )
          //         : null),
        ],
      ),
    );
  }

  void reEmailForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Icon(Icons.cancel),
                  onTap: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        validator: (name) {
                          if (name.isEmpty) {
                            return 'Please enter email!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: (password) {
                          if (password.isEmpty) {
                            return 'Please enter password!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ]),
                )),
          );
        });
  }

  Widget reNameForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Icon(Icons.cancel),
                  onTap: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,
                        autofocus: true,
                        validator: (name) {
                          if (name.isEmpty) {
                            return 'Please enter name!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'New Name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            updateName();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ]),
                )),
          );
        });
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void signOut(BuildContext context) {
    print("sign out");
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        ModalRoute.withName('/'));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _isLoading = true;
        _image = image;
        CompressImage.compress(imageSrc: _image.path, desiredQuality: 50);
        print(_image);
        uploadPic(context);
      });
    }
  }

  Future uploadPic(BuildContext context) async {
    try {
      String fileName = ('images/${DateTime.now()}.png');
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      print(imageUrl);
      updateProfile(imageUrl);
      setState(() {
        print("Profile Picture uploaded");
      });
    } catch (e) {}

    // final ref = FirebaseStorage.instance.ref().child(_image.path);
    // var url = await ref.getDownloadURL();
    // print(url);
  }

  Future updateProfile(imageUrl) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();

      userUpdateInfo.photoUrl = imageUrl;

      userRef.child(widget.user.uid).update({
        "photoUrl": userUpdateInfo.photoUrl,
      });

      setState(() {
        _isLoading = false;

        _photourl = userUpdateInfo.photoUrl;
      });
      await user.updateProfile(userUpdateInfo);
    } catch (e) {}
  }

  Future updateName() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameController.text.trim();

      userRef.child(widget.user.uid).update({
        "name": userUpdateInfo.displayName,
      });

      setState(() {
        _isLoading = false;
        _name = userUpdateInfo.displayName;
      });
      await user.updateProfile(userUpdateInfo);
    } catch (e) {}
  }
}
