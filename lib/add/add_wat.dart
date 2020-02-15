import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:compressimage/compressimage.dart';
import 'package:flutter_travel/add_group.dart';
import 'package:flutter_travel/models/model_travel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddWatPage extends StatefulWidget {
  @override
  _AddWatPageState createState() => _AddWatPageState();

  final Travel travel;
  AddWatPage(this.travel);
}

class _AddWatPageState extends State<AddWatPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final test = Student();
  File _image;
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final callController = TextEditingController();
  final addressController = TextEditingController();

  final desController = TextEditingController();
  final trackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final watReference = FirebaseDatabase.instance.reference().child('wat');

  bool _isLoading;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.travel.title;
    nameController.text = widget.travel.name;
    timeController.text = widget.travel.time;
    callController.text = widget.travel.call;
    addressController.text = widget.travel.address;
    desController.text = widget.travel.desc;
    trackController.text = widget.travel.track;

    test.image = widget.travel.imageUrl;
    test.image2 = widget.travel.imageUrl2;
    test.image3 = widget.travel.imageUrl3;
    test.image4 = widget.travel.imageUrl4;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'เพิ่มวัด',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _showCircularProgress(),
              _buildForm(),
            ],
          ),
        ));
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            showImag(),
            groupImage(),
            titleInput(),
            nameInput(),
            timeInput(),
            callInput(),
            addressInput(),
            SizedBox(
              height: 10,
            ),
            desInput(),
            trackInput(),
            SizedBox(
              height: 10,
            ),
            btnSubmit(),
          ],
        ),
      ),
    );
  }

  Widget showImag() {
    return Container(
      color: Colors.white,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 100.0,
            height: 150.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: test.image == null ? null : Image.network(test.image)),
          ),
          Container(
            width: 100.0,
            height: 150.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: test.image2 == null ? null : Image.network(test.image2)),
          ),
          Container(
            width: 100.0,
            height: 150.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: test.image3 == null ? null : Image.network(test.image3)),
          ),
          Container(
            width: 100.0,
            height: 150.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: test.image4 == null ? null : Image.network(test.image4)),
          ),
        ],
      ),
    );
  }

  Widget groupImage() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: uploadImage(),
              ),
              Expanded(
                child: uploadImage2(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: uploadImage3(),
              ),
              Expanded(
                child: uploadImage4(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget uploadImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
      child: OutlineButton(
        borderSide:
            BorderSide(color: Theme.of(context).accentColor, width: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt),
            SizedBox(
              width: 5.0,
            ),
            Text('Add Image'),
          ],
        ),
        onPressed: () => getImage(),
      ),
    );
  }

  Widget uploadImage2() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
      child: OutlineButton(
        borderSide:
            BorderSide(color: Theme.of(context).accentColor, width: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt),
            SizedBox(
              width: 5.0,
            ),
            Text('Add Image2'),
          ],
        ),
        onPressed: () => getImage2(),
      ),
    );
  }

  Widget uploadImage3() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: OutlineButton(
        borderSide:
            BorderSide(color: Theme.of(context).accentColor, width: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt),
            SizedBox(
              width: 5.0,
            ),
            Text('Add Image3'),
          ],
        ),
        onPressed: () => getImage3(),
      ),
    );
  }

  Widget uploadImage4() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: OutlineButton(
        borderSide:
            BorderSide(color: Theme.of(context).accentColor, width: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt),
            SizedBox(
              width: 5.0,
            ),
            Text('Add Image4'),
          ],
        ),
        onPressed: () => getImage4(),
      ),
    );
  }

  Widget titleInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: titleController,
        decoration: InputDecoration(
          labelText: 'ชื่อสถานที่',
          prefixIcon: Icon(FontAwesomeIcons.cube),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
      ),
    );
  }

  Widget nameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'ตำบล / อำเภอ',
          prefixIcon: Icon(FontAwesomeIcons.cubes),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
      ),
    );
  }

  Widget timeInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        controller: timeController,
        decoration: InputDecoration(
          labelText: 'เวลา',
          prefixIcon: Icon(Icons.timer),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget callInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        controller: callController,
        decoration: InputDecoration(
          labelText: 'เบอร์ติดต่อ',
          prefixIcon: Icon(FontAwesomeIcons.mobileAlt),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        controller: addressController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'ที่อยู่',
          prefixIcon: Icon(FontAwesomeIcons.mapMarked),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget desInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        maxLines: 8,
        controller: desController,
        decoration: InputDecoration(
          labelText: 'รายละเอียด',
          prefixIcon: Icon(Icons.description),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget trackInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: TextFormField(
        controller: trackController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'เส้นทาง',
          prefixIcon: Icon(FontAwesomeIcons.googleDrive),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget btnSubmit() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          onPressed: () {
            if (widget.travel.id != null) {
              update();
            } else {
              add();
            }
          },
          color: Colors.blueAccent,
          textColor: Colors.white,
          child: widget.travel.id == null ? Text('เพิ่ม') : Text('แก้ไข'),
        ),
      ),
    );
  }

  void add() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      watReference.push().set({
        'title': titleController.text,
        'name': nameController.text,
        'time': timeController.text,
        'call': callController.text,
        'address': addressController.text,
        'desc': desController.text,
        'track': trackController.text,
        'imageURL': test.image,
        'imageURL2': test.image2,
        'imageURL3': test.image3,
        'imageURL4': test.image4,
      }).then((_) {
        print('add succress ');
        _formKey.currentState.reset();
        showSnackSuccress();
      });
    } else {
      showSnackError();
    }
  }

  void update() async {
    try {
      watReference.child(widget.travel.id).set({
        'title': titleController.text,
        'name': nameController.text,
        'time': timeController.text,
        'call': callController.text,
        'address': addressController.text,
        'desc': desController.text,
        'track': trackController.text,
        'imageURL': test.image,
        'imageURL2': test.image2,
        'imageURL3': test.image3,
        'imageURL4': test.image4,
      }).then((_) {
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      _image = image;
      CompressImage.compress(imageSrc: _image.path, desiredQuality: 50);
      uploadPic();
      setState(() {
        _isLoading = true;
      });
    } catch (e) {}
  }

  void uploadPic() async {
    String fileName = ('images/${DateTime.now()}.png');
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      test.image = imageUrl;
      _isLoading = false;
    });
  }

  Future getImage2() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      _image = image;
      CompressImage.compress(imageSrc: _image.path, desiredQuality: 50);
      uploadPic2();
      setState(() {
        _isLoading = true;
      });
    } catch (e) {}
  }

  void uploadPic2() async {
    String fileName = ('images/${DateTime.now()}.png');
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      test.image2 = imageUrl;
      _isLoading = false;
    });
  }

  Future getImage3() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      _image = image;
      CompressImage.compress(imageSrc: _image.path, desiredQuality: 50);
      uploadPic3();
      setState(() {
        _isLoading = true;
      });
    } catch (e) {}
  }

  void uploadPic3() async {
    String fileName = ('images/${DateTime.now()}.png');
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      test.image3 = imageUrl;
      _isLoading = false;
    });
  }

  Future getImage4() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      _image = image;
      CompressImage.compress(imageSrc: _image.path, desiredQuality: 50);
      uploadPic4();
      setState(() {
        _isLoading = true;
      });
    } catch (e) {}
  }

  void uploadPic4() async {
    String fileName = ('images/${DateTime.now()}.png');
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      test.image4 = imageUrl;
      _isLoading = false;
    });
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Center(child: CircularProgressIndicator())],
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showSnackSuccress() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("เพิ่มข้อมูลสำเร็จ", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.greenAccent,
    ));
  }

  Widget showSnackError() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
          Text("เพิ่มข้อมูลไม่สำเร็จ", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    ));
  }
}

class Student {
  String image = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
}
